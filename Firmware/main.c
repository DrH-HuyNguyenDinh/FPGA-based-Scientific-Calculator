#include <stdint.h>

/*
 * ============================================================
 * Project : RV32IF + PS/2 Keyboard + LCD ST7920 Simple Calculator
 * File    : main.c
 * Board   : DE10
 * Clock   : 20 MHz
 * ============================================================
 */

/* ============================================================
 * MMIO
 * ============================================================ */
#define REG_LEDR (*(volatile uint32_t*)0x10000000u)
#define REG_LCD  (*(volatile uint32_t*)0x10004000u)
#define REG_PS2  (*(volatile uint32_t*)0x10010000u)

#define LCD_RS_BIT   8
#define LCD_RW_BIT   9
#define LCD_EN_BIT   10
#define LCD_RST_BIT  11

#define LCD_RS   (1u << LCD_RS_BIT)
#define LCD_RW   (1u << LCD_RW_BIT)
#define LCD_EN   (1u << LCD_EN_BIT)
#define LCD_RST  (1u << LCD_RST_BIT)

#define PS2_DATA_MASK   0x000000FFu
#define PS2_READY_MASK  (1u << 8)
#define PS2_ERROR_MASK  (1u << 9)

/* ============================================================
 * Text screen config
 * ============================================================ */
#define LCD_ROWS 4
#define LCD_COLS 16
#define EXPR_MAX_LEN 16
#define RESULT_MAX_LEN 32 // Tăng lên 32 để chống tràn bộ nhớ gây lỗi rác

/* ============================================================
 * Constants
 * ============================================================ */
#define MY_PI          3.14159265358979323846f
#define MY_HALF_PI     1.57079632679489661923f
#define MY_QUARTER_PI  0.78539816339744830962f
#define MY_TAN_PI_8    0.41421356237309504880f
#define MY_TWO_PI      6.28318530717958647692f
#define MY_INV_TWO_PI  0.15915494309189533577f
#define MY_E           2.71828182845904523536f
#define MY_LN2         0.69314718055994530942f
#define MY_INV_LN2     1.44269504088896340736f
#define MY_LN10        2.30258509299404568402f
#define MY_INV_LN10    0.43429448190325182765f
#define HYP_LIMIT      1.118f
#define HYP_SAFE_EPS   0.0005f
#define HYP_SAFE_LIMIT (HYP_LIMIT - HYP_SAFE_EPS)
#define TAN_SAFE_EPS   0.000001f

/* ============================================================
 * Global state
 * ============================================================ */
static char g_screen[LCD_ROWS][LCD_COLS];
static char g_expr[EXPR_MAX_LEN + 1];
static uint8_t g_expr_len = 0u;
static uint8_t g_cursor_pos = 0u;
static char g_result[RESULT_MAX_LEN + 1];

static uint8_t g_prefix_f0 = 0u;
static uint8_t g_prefix_e0 = 0u;
static uint8_t g_lshift_pressed = 0u;
static uint8_t g_rshift_pressed = 0u;

// --- BIẾN ĐỒ HỌA MỚI (SỬ DỤNG SỐ NGUYÊN) ---
static uint8_t g_gdram[64][16];        // Graphic RAM (128x64 pixels)
static uint8_t g_is_graphic_mode = 0u; // Trạng thái hiển thị LCD
static int32_t g_var_x_int = 0;        // Biến tọa độ X dành cho số nguyên

/* ============================================================
 * Parser state
 * ============================================================ */
typedef struct {
    const char *p;
    uint8_t error;
    uint8_t div0;
    uint8_t unsupported;
} Parser;

typedef struct {
    const char *p;
    uint8_t error;
    uint8_t div0;
    uint8_t domain;
} FParser;

/* ============================================================
 * 1. STATIC INLINE WRAPPERS (CUSTOM CORDIC)
 * ============================================================ */
static inline float c_fsin(float x) {
    float res;
    asm volatile (".insn r 0x53, 0x0, 0x34, %0, %1, f0" : "=f"(res) : "f"(x));
    return res;
}
static inline float c_fcos(float x) {
    float res;
    asm volatile (".insn r 0x53, 0x0, 0x30, %0, %1, f0" : "=f"(res) : "f"(x));
    return res;
}
static inline float c_fsinh(float x) {
    float res;
    asm volatile (".insn r 0x53, 0x0, 0x3C, %0, %1, f0" : "=f"(res) : "f"(x));
    return res;
}
static inline float c_fcosh(float x) {
    float res;
    asm volatile (".insn r 0x53, 0x0, 0x38, %0, %1, f0" : "=f"(res) : "f"(x));
    return res;
}
static inline float c_fatanh(float x) {
    float res;
    asm volatile (".insn r 0x53, 0x0, 0x40, %0, %1, f0" : "=f"(res) : "f"(x));
    return res;
}
static inline float c_fsqrt(float x) {
    float res;
    asm volatile ("fsqrt.s %0, %1" : "=f"(res) : "f"(x));
    return res;
}

/* ============================================================
 * Forward declarations
 * ============================================================ */
static void delay_us(int us);
static void delay_ms(int ms);

static void lcd_pulse_en(uint32_t current_val);
static void lcd_write(uint8_t data, uint8_t is_data);
static void lcd_write_cmd(uint8_t cmd);
static void lcd_write_data(uint8_t data);
static void lcd_init(void);
static void lcd_hard_init(void);
static void lcd_clear(void);
static void lcd_set_cursor(uint8_t row, uint8_t col);
static void lcd_write_line_padded(uint8_t row, const char *line16);

static void str_clear(char *s);
static void str_copy(char *dst, const char *src);
static uint32_t str_len(const char *s);
static uint8_t is_digit_char(char c);
static uint8_t is_space_char(char c);
static uint8_t is_alpha_char(char c);
static uint8_t is_alnum_or_uscore(char c);
static char to_lower_char(char c);
static void int_to_str(int32_t value, char *out);
static void u64_to_dec_str(uint64_t value, char *out);
static void trim_frac_zeros(char *s);
static void float_to_dec_str(float value, char *out);

static void screen_init_buffer(void);
static void screen_flush_row(uint8_t row);
static void screen_clear_all(void);
static void input_refresh_row(void);
static void result_refresh_row(void);
static void input_append_char(char c);
static void input_backspace(void);
static void input_delete_at_cursor(void);
static void input_cursor_left(void);
static void input_cursor_right(void);
static void input_cursor_home(void);
static void input_cursor_end(void);
static void input_clear(void);

static void parser_skip_spaces(Parser *ps);
static int32_t parse_expression(Parser *ps);
static int32_t parse_term(Parser *ps);
static int32_t parse_factor(Parser *ps);
static int32_t parse_primary(Parser *ps);
static int32_t parse_number(Parser *ps);
static int eval_expression(const char *text, int32_t *out_value);

static float my_absf(float x);
static float digit_to_float(uint8_t d);
static float int_to_float_small(int v);
static int round_nearest_int(float x);
static float scale_pow2(float x, int k);
static float clamp_hyp_range(float x);
static uint8_t hyp_input_ok(float x);
static float reduce_angle_to_pi(float x);
static float my_sin(float x);
static float my_cos(float x);
static float my_tan(float x);
static float my_atan_poly(float z);
static float my_atan(float x);
static float my_asin(float x);
static float my_acos(float x);
static float my_sinh(float x);
static float my_cosh(float x);
static uint8_t my_exp(float x, float *out);
static uint8_t my_ln(float x, float *out);
static uint8_t my_log10(float x, float *out);
static uint8_t my_log(float x, float y, float *out);
static uint8_t my_pow(float x, float y, float *out);

static void fparser_skip_spaces(FParser *ps);
static float f_parse_expression(FParser *ps);
static float f_parse_term(FParser *ps);
static float f_parse_power(FParser *ps);
static float f_parse_unary(FParser *ps);
static float f_parse_primary(FParser *ps);
static float f_pow10_inv(uint8_t idx);
static float f_parse_number(FParser *ps);
static int eval_float_expression(const char *text, float *out_value);
static uint8_t expr_requires_float(const char *text);
static void calculate_current_expression(void);

static uint8_t shift_active(void);
static int translate_ps2_make_to_char(uint8_t raw, uint8_t is_ext, char *out_char);
static void handle_ps2_complete_code(uint8_t raw, uint8_t error);
static void ps2_reset_state(void);

/* ============================================================
 * Delay
 * ============================================================ */
static void delay_us(int us) {
    volatile int count = (us * 20) / 4;
    while (count > 0) {
        count--;
    }
}

static void delay_ms(int ms) {
    while (ms > 0) {
        delay_us(1000);
        ms--;
    }
}

/* ============================================================
 * LCD low-level & Graphic Draw
 * ============================================================ */
static void lcd_pulse_en(uint32_t current_val) {
    REG_LCD = current_val | LCD_EN;
    delay_us(2);
    REG_LCD = current_val & ~LCD_EN;
    delay_us(72);
}

static void lcd_write(uint8_t data, uint8_t is_data) {
    uint32_t val = (uint32_t)data;

    if (is_data) val |= LCD_RS;
    else         val &= ~LCD_RS;

    val &= ~LCD_RW;
    val |= LCD_RST;

    REG_LCD = val;
    lcd_pulse_en(val);
}

static void lcd_write_cmd(uint8_t cmd) {
    lcd_write(cmd, 0u);
}

static void lcd_write_data(uint8_t data) {
    lcd_write(data, 1u);
}

static void lcd_clear(void) {
    lcd_write_cmd(0x01u);
    delay_us(2000);
}

static void lcd_init(void) {
    REG_LCD = 0u;
    delay_us(1000);
    REG_LCD = LCD_RST;
    delay_us(50000);

    lcd_write_cmd(0x30u); delay_us(150);
    lcd_write_cmd(0x0Cu); delay_us(150); // Cấm 0x0F
    lcd_write_cmd(0x01u); delay_us(2000);
}

static void lcd_hard_init(void) {
    REG_LCD = 0u;
    delay_ms(10);
    REG_LCD = LCD_RST;
    delay_ms(50);
    lcd_write_cmd(0x30u); delay_ms(2);
    lcd_write_cmd(0x30u); delay_ms(2);
    lcd_write_cmd(0x0Cu); delay_ms(2); // Cấm 0x0F
    lcd_write_cmd(0x01u); delay_ms(3);
    lcd_write_cmd(0x06u); delay_ms(2);
}

static void lcd_set_cursor(uint8_t row, uint8_t col) {
    uint8_t addr;

    if (row == 0u)      addr = (uint8_t)(0x80u + col);
    else if (row == 1u) addr = (uint8_t)(0x90u + col);
    else if (row == 2u) addr = (uint8_t)(0x88u + col);
    else                addr = (uint8_t)(0x98u + col);

    lcd_write_cmd(addr);
}

static void lcd_write_line_padded(uint8_t row, const char *line16) {
    uint8_t i;

    lcd_set_cursor(row, 0u);
    for (i = 0u; i < LCD_COLS; i++) {
        lcd_write_data((uint8_t)line16[i]);
    }
}

// Bơm Graphic xuống phần cứng bằng cách truyền cặp 16-bit
static void lcd_flush_graphic(void) {
    uint8_t y, x;
    
    lcd_write_cmd(0x34u); // Bật cờ Extended Mode
    delay_ms(1);
    
    for (y = 0u; y < 64u; y++) {
        uint8_t drv_y = (y < 32u) ? y : (y - 32u);
        uint8_t drv_x = (y < 32u) ? 0x80u : 0x88u;
        
        for (x = 0u; x < 8u; x++) {
            lcd_write_cmd(0x80u | drv_y);        
            lcd_write_cmd(drv_x + x);            
            lcd_write_data(g_gdram[y][x * 2]);     
            lcd_write_data(g_gdram[y][x * 2 + 1]); 
        }
    }
    
    lcd_write_cmd(0x36u); // Bật màn hình Graphic ON
    delay_ms(1);
}

// THUẬT TOÁN VẼ ĐỒ THỊ SỐ NGUYÊN (INT)
static void draw_graph(const char *inner_expr) {
    int px, r, c;
    int32_t y_val;

    // Xóa sạch bộ đệm Graphic
    for (r = 0; r < 64; r++) {
        for (c = 0; c < 16; c++) {
            g_gdram[r][c] = 0u;
        }
    }

    // Vẽ 2 trục tọa độ OXY (Trục hoành ở y=32, Trục tung ở x=64)
    for (px = 0; px < 128; px++) g_gdram[32][px >> 3] |= (1u << (7 - (px & 7))); 
    for (r = 0; r < 64; r++)     g_gdram[r][64 >> 3]  |= (1u << (7 - (64 & 7))); 

    // Quét điểm ảnh từ trái sang phải (px từ 0 đến 127)
    // Tọa độ toán học: x sẽ chạy từ -64 đến +63
    for (px = 0; px < 128; px++) {
        g_var_x_int = px - 64; 
        
        // Chỉ vẽ điểm nếu biểu thức hợp lệ
        if (eval_expression(inner_expr, &y_val)) {
            
            // Ánh xạ trục tung: Góc màn hình LCD là y=0 (trên cùng). 
            // Do trục y toán học hướng lên, ta đảo ngược nó: py = 32 - y
            int py = 32 - (int)y_val;
            
            if (py >= 0 && py < 64) {
                g_gdram[py][px >> 3] |= (1u << (7 - (px & 7)));
            }
        }
    }

    g_is_graphic_mode = 1u;
    lcd_flush_graphic();
}

/* ============================================================
 * String helpers
 * ============================================================ */
static void str_clear(char *s) {
    s[0] = '\0';
}

static void str_copy(char *dst, const char *src) {
    while (*src) {
        *dst++ = *src++;
    }
    *dst = '\0';
}

static uint32_t str_len(const char *s) {
    uint32_t n = 0u;
    while (s[n] != '\0') n++;
    return n;
}

static uint8_t is_digit_char(char c) {
    return (uint8_t)(c >= '0' && c <= '9');
}

static uint8_t is_space_char(char c) {
    return (uint8_t)(c == ' ' || c == '\t' || c == '\r' || c == '\n');
}

static uint8_t is_alpha_char(char c) {
    return (uint8_t)((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'));
}

static uint8_t is_alnum_or_uscore(char c) {
    return (uint8_t)(is_alpha_char(c) || is_digit_char(c) || c == '_');
}

static char to_lower_char(char c) {
    if (c >= 'A' && c <= 'Z') return (char)(c - 'A' + 'a');
    return c;
}

static void int_to_str(int32_t value, char *out) {
    char tmp[16];
    uint32_t i = 0u;
    uint32_t j = 0u;
    uint8_t neg = 0u;
    int32_t v = value;

    if (v == 0) {
        out[0] = '0';
        out[1] = '\0';
        return;
    }

    if (v < 0) {
        neg = 1u;
        v = -v;
    }

    while (v > 0) {
        tmp[i++] = (char)('0' + (v % 10));
        v /= 10;
    }

    if (neg) out[j++] = '-';

    while (i > 0u) {
        out[j++] = tmp[--i];
    }

    out[j] = '\0';
}

static void u64_to_dec_str(uint64_t value, char *out) {
    char tmp[24];
    uint32_t i = 0u;
    uint32_t j = 0u;

    if (value == 0ULL) {
        out[0] = '0';
        out[1] = '\0';
        return;
    }

    while (value > 0ULL) {
        tmp[i++] = (char)('0' + (uint32_t)(value % 10ULL));
        value /= 10ULL;
    }

    while (i > 0u) {
        out[j++] = tmp[--i];
    }

    out[j] = '\0';
}

static void trim_frac_zeros(char *s) {
    int32_t len = (int32_t)str_len(s);

    while (len > 0 && s[len - 1] == '0') {
        s[len - 1] = '\0';
        len--;
    }

    if (len > 0 && s[len - 1] == '.') {
        s[len - 1] = '\0';
    }
}

static void float_to_dec_str(float value, char *out) {
    union {
        float f;
        uint32_t u;
    } conv;

    uint32_t sign;
    uint32_t exp_field;
    uint32_t frac_field;
    uint32_t mant;
    int32_t exp2;
    uint64_t scaled;
    uint64_t numer;
    uint64_t whole;
    uint32_t frac;
    char intbuf[24];
    char fracbuf[8];
    uint32_t idx = 0u;

    conv.f = value;
    sign = conv.u >> 31;
    exp_field = (conv.u >> 23) & 0xFFu;
    frac_field = conv.u & 0x7FFFFFu;

    if (exp_field == 0xFFu) {
        if (frac_field != 0u) str_copy(out, "NAN");
        else if (sign)        str_copy(out, "-INF");
        else                  str_copy(out, "INF");
        return;
    }

    if ((conv.u & 0x7FFFFFFFu) == 0u) {
        str_copy(out, "0");
        return;
    }

    if (exp_field == 0u) {
        mant = frac_field;
        exp2 = -126 - 23;
    } else {
        mant = 0x800000u | frac_field;
        exp2 = (int32_t)exp_field - 127 - 23;
    }

    numer = ((uint64_t)mant) * 1000000ULL;

    if (exp2 >= 0) {
        if (exp2 > 31) {
            str_copy(out, "OVERFLOW");
            return;
        }

        scaled = numer << (uint32_t)exp2;
    } else {
        uint32_t sh = (uint32_t)(-exp2);

        if (sh >= 64u) {
            scaled = 0ULL;
        } else {
            uint64_t round = (sh == 0u) ? 0ULL : (1ULL << (sh - 1u));
            scaled = (numer + round) >> sh;
        }
    }

    whole = scaled / 1000000ULL;
    frac  = (uint32_t)(scaled % 1000000ULL);

    str_clear(out);

    if (sign) {
        out[idx++] = '-';
        out[idx] = '\0';
    }

    u64_to_dec_str(whole, intbuf);
    str_copy(out + idx, intbuf);
    idx = (uint32_t)str_len(out);

    if (frac == 0u) return;

    out[idx++] = '.';
    out[idx] = '\0';

    fracbuf[0] = (char)('0' + ((frac / 100000u) % 10u));
    fracbuf[1] = (char)('0' + ((frac / 10000u)  % 10u));
    fracbuf[2] = (char)('0' + ((frac / 1000u)   % 10u));
    fracbuf[3] = (char)('0' + ((frac / 100u)    % 10u));
    fracbuf[4] = (char)('0' + ((frac / 10u)     % 10u));
    fracbuf[5] = (char)('0' + ( frac            % 10u));
    fracbuf[6] = '\0';

    str_copy(out + idx, fracbuf);
    trim_frac_zeros(out);
}

/* ============================================================
 * Screen model (THUẬT TOÁN CHÈN CON TRỎ | ẢO)
 * ============================================================ */
static void screen_init_buffer(void) {
    uint8_t row;
    uint8_t col;

    for (row = 0u; row < LCD_ROWS; row++) {
        for (col = 0u; col < LCD_COLS; col++) {
            g_screen[row][col] = ' ';
        }
    }

    str_clear(g_expr);
    g_expr_len = 0u;
    g_cursor_pos = 0u;
    str_clear(g_result);
}

static void screen_flush_row(uint8_t row) {
    lcd_write_line_padded(row, g_screen[row]);
}

static void screen_clear_all(void) {
    screen_init_buffer();
    lcd_clear();

    screen_flush_row(0u);
    screen_flush_row(1u);
    screen_flush_row(2u);
    screen_flush_row(3u);
}

static void input_refresh_row(void) {
    uint8_t i, scr_idx = 0;

    for (i = 0u; i < LCD_COLS; i++) {
        g_screen[0][i] = ' ';
    }

    // Tự động chen ký tự '|' vào bộ đệm màn hình tại g_cursor_pos
    // Giữ nguyên chuỗi toán học g_expr để không làm hỏng phép tính
    for (i = 0u; i <= g_expr_len; i++) {
        if (i == g_cursor_pos && scr_idx < LCD_COLS) {
            g_screen[0][scr_idx++] = '|';
        }
        if (i < g_expr_len && scr_idx < LCD_COLS) {
            g_screen[0][scr_idx++] = g_expr[i];
        }
    }

    screen_flush_row(0u);
}

static void result_refresh_row(void) {
    uint8_t i;
    uint32_t len;

    for (i = 0u; i < LCD_COLS; i++) {
        g_screen[3][i] = ' ';
    }

    len = str_len(g_result);

    if (len > LCD_COLS) {
        len = LCD_COLS;
    }

    for (i = 0u; i < (uint8_t)len; i++) {
        g_screen[3][i] = g_result[i];
    }

    screen_flush_row(3u);
}

static void input_append_char(char c) {
    if (g_expr_len >= EXPR_MAX_LEN) return;

    for (int i = (int)g_expr_len; i > (int)g_cursor_pos; i--) {
        g_expr[i] = g_expr[i - 1];
    }

    g_expr[g_cursor_pos] = c;
    g_expr_len++;
    g_cursor_pos++;
    g_expr[g_expr_len] = '\0';

    input_refresh_row();
}

static void input_backspace(void) {
    if (g_cursor_pos == 0u) return;

    for (int i = (int)g_cursor_pos; i < (int)g_expr_len; i++) {
        g_expr[i - 1] = g_expr[i];
    }

    g_expr_len--;
    g_cursor_pos--;
    g_expr[g_expr_len] = '\0';

    input_refresh_row();
}

static void input_delete_at_cursor(void) {
    int i;

    if (g_cursor_pos >= g_expr_len) return;

    for (i = (int)g_cursor_pos; i < (int)g_expr_len; i++) {
        g_expr[i] = g_expr[i + 1];
    }

    g_expr_len--;
    g_expr[g_expr_len] = '\0';

    input_refresh_row();
}

static void input_cursor_left(void) {
    if (g_cursor_pos > 0u) {
        g_cursor_pos--;
        input_refresh_row();
    }
}

static void input_cursor_right(void) {
    if (g_cursor_pos < g_expr_len) {
        g_cursor_pos++;
        input_refresh_row();
    }
}

static void input_cursor_home(void) {
    g_cursor_pos = 0u;
    input_refresh_row();
}

static void input_cursor_end(void) {
    g_cursor_pos = g_expr_len;
    input_refresh_row();
}

static void input_clear(void) {
    str_clear(g_expr);
    g_expr_len = 0u;
    g_cursor_pos = 0u;
    str_clear(g_result);

    input_refresh_row();
    result_refresh_row();
}

/* ============================================================
 * Integer parser (ĐÃ DẠY PARSER NHẬN DIỆN BIẾN X CỦA GRAPH)
 * ============================================================ */
static void parser_skip_spaces(Parser *ps) {
    while (is_space_char(*ps->p)) {
        ps->p++;
    }
}

static int32_t parse_number(Parser *ps) {
    int32_t v = 0;
    uint8_t seen = 0u;

    parser_skip_spaces(ps);

    while (is_digit_char(*ps->p)) {
        seen = 1u;
        v = v * 10 + (int32_t)(*ps->p - '0');
        ps->p++;
    }

    if (!seen) {
        ps->error = 1u;
    }

    return v;
}

static int32_t parse_primary(Parser *ps) {
    int32_t v;

    parser_skip_spaces(ps);

    if (*ps->p == '.') {
        ps->unsupported = 1u;
        ps->error = 1u;
        return 0;
    }

    if (*ps->p == '(') {
        ps->p++;

        v = parse_expression(ps);

        parser_skip_spaces(ps);

        if (*ps->p != ')') {
            ps->error = 1u;
            return 0;
        }

        ps->p++;
        return v;
    }

    // --- SỬA LỖI Ở ĐÂY: Dạy Parser số nguyên hiểu biến 'x' ---
    if (*ps->p == 'x' || *ps->p == 'X') {
        ps->p++;
        return g_var_x_int;
    }

    return parse_number(ps);
}

static int32_t parse_factor(Parser *ps) {
    parser_skip_spaces(ps);

    if (*ps->p == '+') {
        ps->p++;
        return parse_factor(ps);
    }

    if (*ps->p == '-') {
        ps->p++;
        return -parse_factor(ps);
    }

    return parse_primary(ps);
}

static int32_t parse_term(Parser *ps) {
    int32_t lhs = parse_factor(ps);

    while (!ps->error) {
        char op;
        int32_t rhs;

        parser_skip_spaces(ps);

        op = *ps->p;

        if (op != '*' && op != '/') {
            break;
        }

        ps->p++;

        rhs = parse_factor(ps);

        if (ps->error) {
            return 0;
        }

        if (op == '*') {
            lhs = lhs * rhs;
        } else {
            if (rhs == 0) {
                ps->div0 = 1u;
                ps->error = 1u;
                return 0;
            }

            lhs = lhs / rhs;
        }
    }

    return lhs;
}

static int32_t parse_expression(Parser *ps) {
    int32_t lhs = parse_term(ps);

    while (!ps->error) {
        char op;
        int32_t rhs;

        parser_skip_spaces(ps);

        op = *ps->p;

        if (op != '+' && op != '-') {
            break;
        }

        ps->p++;

        rhs = parse_term(ps);

        if (ps->error) {
            return 0;
        }

        if (op == '+') {
            lhs += rhs;
        } else {
            lhs -= rhs;
        }
    }

    return lhs;
}

static int eval_expression(const char *text, int32_t *out_value) {
    Parser ps;
    int32_t v;

    ps.p = text;
    ps.error = 0u;
    ps.div0 = 0u;
    ps.unsupported = 0u;

    v = parse_expression(&ps);
    parser_skip_spaces(&ps);

    if (ps.error || *ps.p != '\0') {
        if (ps.div0) {
            str_copy(g_result, "DIV0");
        } else if (ps.unsupported) {
            str_copy(g_result, "ERROR");
        } else {
            str_copy(g_result, "ERROR");
        }

        return 0;
    }

    *out_value = v;
    return 1;
}

/* ============================================================
 * Float helpers / math (Giữ nguyên gốc của bạn)
 * ============================================================ */
static float my_absf(float x) {
    return (x < 0.0f) ? -x : x;
}

static float digit_to_float(uint8_t d) {
    switch (d) {
        case 0u: return 0.0f;
        case 1u: return 1.0f;
        case 2u: return 2.0f;
        case 3u: return 3.0f;
        case 4u: return 4.0f;
        case 5u: return 5.0f;
        case 6u: return 6.0f;
        case 7u: return 7.0f;
        case 8u: return 8.0f;
        default: return 9.0f;
    }
}

static float int_to_float_small(int v) {
    float acc = 0.0f;
    uint8_t neg = 0u;

    if (v < 0) {
        neg = 1u;
        v = -v;
    }

    while (v >= 8) {
        acc += 8.0f;
        v -= 8;
    }

    while (v > 0) {
        acc += 1.0f;
        v--;
    }

    return neg ? -acc : acc;
}

static int round_nearest_int(float x) {
    if (x >= 0.0f) return (int)(x + 0.5f);
    return (int)(x - 0.5f);
}

static float scale_pow2(float x, int k) {
    if (k > 0) {
        while (k--) {
            x = x * 2.0f;
        }
    } else if (k < 0) {
        while (k++) {
            x = x * 0.5f;
        }
    }

    return x;
}

static float clamp_hyp_range(float x) {
    if (x > HYP_SAFE_LIMIT) {
        return HYP_SAFE_LIMIT;
    }

    if (x < -HYP_SAFE_LIMIT) {
        return -HYP_SAFE_LIMIT;
    }

    return x;
}

static uint8_t hyp_input_ok(float x) {
    return (uint8_t)(x >= -HYP_LIMIT && x <= HYP_LIMIT);
}

static float reduce_angle_to_pi(float x) {
    int k;

    if (x > MY_PI || x < -MY_PI) {
        k = round_nearest_int(x * MY_INV_TWO_PI);
        x = x - ((float)k * MY_TWO_PI);

        if (x > MY_PI) {
            x = x - MY_TWO_PI;
        } else if (x < -MY_PI) {
            x = x + MY_TWO_PI;
        }
    }

    return x;
}

static float my_sin(float x) {
    x = reduce_angle_to_pi(x);
    return c_fsin(x);
}

static float my_cos(float x) {
    x = reduce_angle_to_pi(x);
    return c_fcos(x);
}

static float my_tan(float x) {
    return my_sin(x) / my_cos(x);
}

static float my_atan_poly(float z) {
    float z2 = z * z;
    float p;

    p =  0.04f;                         
    p = -0.043478260869565216f + z2 * p;
    p =  0.047619047619047619f + z2 * p;
    p = -0.052631578947368421f + z2 * p;
    p =  0.058823529411764706f + z2 * p;
    p = -0.066666666666666667f + z2 * p;
    p =  0.076923076923076923f + z2 * p;
    p = -0.090909090909090909f + z2 * p;
    p =  0.111111111111111111f + z2 * p;
    p = -0.142857142857142857f + z2 * p;
    p =  0.2f                  + z2 * p;
    p = -0.333333333333333333f + z2 * p;
    p =  1.0f                  + z2 * p;

    return z * p;
}

static float my_atan(float x) {
    uint8_t neg = 0u;
    float y;
    float u;
    float z;

    if (x < 0.0f) {
        neg = 1u;
        x = -x;
    }

    if (x > 1.0f) {
        u = 1.0f / x;

        if (u > MY_TAN_PI_8) {
            z = (u - 1.0f) / (u + 1.0f);
            y = MY_HALF_PI - (MY_QUARTER_PI + my_atan_poly(z));
        } else {
            y = MY_HALF_PI - my_atan_poly(u);
        }
    } else if (x > MY_TAN_PI_8) {
        z = (x - 1.0f) / (x + 1.0f);
        y = MY_QUARTER_PI + my_atan_poly(z);
    } else {
        y = my_atan_poly(x);
    }

    return neg ? -y : y;
}

static float my_asin(float x) {
    uint8_t neg = 0u;
    float u;
    float y;
    float t;

    if (x > 1.0f || x < -1.0f) {
        return 0.0f;
    }

    if (x < 0.0f) {
        neg = 1u;
        x = -x;
    }

    if (x >= 1.0f) {
        return neg ? -MY_HALF_PI : MY_HALF_PI;
    }

    u = x;

    if (u > 0.5f) {
        t = c_fsqrt((1.0f - u) / (1.0f + u));
        y = MY_HALF_PI - (2.0f * my_atan(t));
    } else {
        t = u / (1.0f + c_fsqrt((1.0f - u) * (1.0f + u)));
        y = 2.0f * my_atan(t);
    }

    return neg ? -y : y;
}

static float my_acos(float x) {
    if (x > 1.0f || x < -1.0f) {
        return 0.0f;
    }

    if (x >= 1.0f) {
        return 0.0f;
    }

    if (x <= -1.0f) {
        return MY_PI;
    }

    return MY_HALF_PI - my_asin(x);
}

static float my_sinh(float x) {
    return c_fsinh(x);
}

static float my_cosh(float x) {
    return c_fcosh(x);
}

static uint8_t my_exp(float x, float *out) {
    if (!hyp_input_ok(x)) {
        return 0u;
    }

    *out = c_fsinh(x) + c_fcosh(x);
    return 1u;
}

static uint8_t my_ln(float x, float *out) {
    float z;

    if (x <= 0.0f) {
        return 0u;
    }

    z = (x - 1.0f) / (x + 1.0f);

    if (z <= -1.0f || z >= 1.0f) {
        return 0u;
    }

    if (!hyp_input_ok(z)) {
        return 0u;
    }

    *out = 2.0f * c_fatanh(z);
    return 1u;
}

static uint8_t my_log10(float x, float *out) {
    float ln_x;

    if (!my_ln(x, &ln_x)) {
        return 0u;
    }

    *out = ln_x * MY_INV_LN10;
    return 1u;
}

static uint8_t my_log(float x, float y, float *out) {
    float ln_base;
    float ln_value;

    if (x <= 0.0f || x == 1.0f || y <= 0.0f) {
        return 0u;
    }

    if (!my_ln(x, &ln_base)) {
        return 0u;
    }

    if (ln_base == 0.0f) {
        return 0u;
    }

    if (!my_ln(y, &ln_value)) {
        return 0u;
    }

    *out = ln_value / ln_base;
    return 1u;
}

static uint8_t my_pow(float x, float y, float *out) {
    float ln_x;
    float t;

    if (x <= 0.0f) {
        return 0u;
    }

    if (!my_ln(x, &ln_x)) {
        return 0u;
    }

    t = y * ln_x;

    if (!hyp_input_ok(t)) {
        return 0u;
    }

    return my_exp(t, out);
}

/* ============================================================
 * Float parser (Giữ nguyên gốc của bạn)
 * ============================================================ */
static void fparser_skip_spaces(FParser *ps) {
    while (is_space_char(*ps->p)) {
        ps->p++;
    }
}

static float f_pow10_inv(uint8_t idx) {
    switch (idx) {
        case 0u: return 0.1f;
        case 1u: return 0.01f;
        case 2u: return 0.001f;
        case 3u: return 0.0001f;
        case 4u: return 0.00001f;
        case 5u: return 0.000001f;
        default: return 0.0f;
    }
}

static float f_parse_number(FParser *ps) {
    float whole = 0.0f;
    float frac  = 0.0f;
    uint8_t seen = 0u;
    uint8_t frac_idx = 0u;
    uint8_t d;

    fparser_skip_spaces(ps);

    while (is_digit_char(*ps->p)) {
        seen = 1u;
        d = (uint8_t)(*ps->p - '0');
        whole = whole * 10.0f + digit_to_float(d);
        ps->p++;
    }

    if (*ps->p == '.') {
        ps->p++;

        while (is_digit_char(*ps->p)) {
            seen = 1u;
            d = (uint8_t)(*ps->p - '0');

            if (frac_idx < 6u) {
                frac += digit_to_float(d) * f_pow10_inv(frac_idx);
                frac_idx++;
            }

            ps->p++;
        }
    }

    if (!seen) {
        ps->error = 1u;
    }

    return whole + frac;
}

static float f_parse_expression(FParser *ps);

static float f_parse_primary(FParser *ps) {
    char name[16];
    uint8_t n = 0u;
    float a;
    float b;
    float c;

    fparser_skip_spaces(ps);

    if (*ps->p == '(') {
        ps->p++;

        a = f_parse_expression(ps);

        fparser_skip_spaces(ps);

        if (*ps->p != ')') {
            ps->error = 1u;
            return 0.0f;
        }

        ps->p++;
        return a;
    }

    if (is_digit_char(*ps->p) || *ps->p == '.') {
        return f_parse_number(ps);
    }

    if (is_alpha_char(*ps->p)) {
        while (is_alnum_or_uscore(*ps->p) && n < 15u) {
            name[n++] = to_lower_char(*ps->p);
            ps->p++;
        }

        name[n] = '\0';

        fparser_skip_spaces(ps);

        if (*ps->p != '(') {
            if (name[0] == 'p' && name[1] == 'i' && name[2] == '\0') {
                return MY_PI;
            }

            if (name[0] == 'e' && name[1] == '\0') {
                return MY_E;
            }

            ps->error = 1u;
            return 0.0f;
        }

        ps->p++;

        a = f_parse_expression(ps);

        fparser_skip_spaces(ps);

        /* sqrt(x) */
        if (name[0] == 's' &&
            name[1] == 'q' &&
            name[2] == 'r' &&
            name[3] == 't' &&
            name[4] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (a < 0.0f) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c_fsqrt(a);
        }

        /* sin(x) */
        if (name[0] == 's' &&
            name[1] == 'i' &&
            name[2] == 'n' &&
            name[3] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_sin(a);
        }

        /* cos(x) */
        if (name[0] == 'c' &&
            name[1] == 'o' &&
            name[2] == 's' &&
            name[3] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_cos(a);
        }

        /* tan(x) = sin(x) / cos(x) */
        if (name[0] == 't' &&
            name[1] == 'a' &&
            name[2] == 'n' &&
            name[3] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            c = my_cos(a);
            if (my_absf(c) < TAN_SAFE_EPS) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_tan(a);
        }

        /* asin(x) */
        if (name[0] == 'a' &&
            name[1] == 's' &&
            name[2] == 'i' &&
            name[3] == 'n' &&
            name[4] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (a < -1.0f || a > 1.0f) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_asin(a);
        }

        /* acos(x) */
        if (name[0] == 'a' &&
            name[1] == 'c' &&
            name[2] == 'o' &&
            name[3] == 's' &&
            name[4] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (a < -1.0f || a > 1.0f) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_acos(a);
        }

        /* atan(x) */
        if (name[0] == 'a' &&
            name[1] == 't' &&
            name[2] == 'a' &&
            name[3] == 'n' &&
            name[4] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_atan(a);
        }

        /* sinh(x) */
        if (name[0] == 's' &&
            name[1] == 'i' &&
            name[2] == 'n' &&
            name[3] == 'h' &&
            name[4] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (!hyp_input_ok(a)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_sinh(a);
        }

        /* cosh(x) */
        if (name[0] == 'c' &&
            name[1] == 'o' &&
            name[2] == 's' &&
            name[3] == 'h' &&
            name[4] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (!hyp_input_ok(a)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return my_cosh(a);
        }

        /* atanh(x) */
        if (name[0] == 'a' &&
            name[1] == 't' &&
            name[2] == 'a' &&
            name[3] == 'n' &&
            name[4] == 'h' &&
            name[5] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (my_absf(a) >= 1.0f || !hyp_input_ok(a)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c_fatanh(a);
        }

        /* arctanh(x) */
        if (name[0] == 'a' &&
            name[1] == 'r' &&
            name[2] == 'c' &&
            name[3] == 't' &&
            name[4] == 'a' &&
            name[5] == 'n' &&
            name[6] == 'h' &&
            name[7] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (my_absf(a) >= 1.0f || !hyp_input_ok(a)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c_fatanh(a);
        }

        /* exp(x) = e^x */
        if (name[0] == 'e' &&
            name[1] == 'x' &&
            name[2] == 'p' &&
            name[3] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (!my_exp(a, &c)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c;
        }

        /* ln(x) */
        if (name[0] == 'l' &&
            name[1] == 'n' &&
            name[2] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (!my_ln(a, &c)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c;
        }

        /* log10(x) */
        if (name[0] == 'l' &&
            name[1] == 'o' &&
            name[2] == 'g' &&
            name[3] == '1' &&
            name[4] == '0' &&
            name[5] == '\0') {

            if (*ps->p != ')') {
                ps->error = 1u;
                return 0.0f;
            }

            if (!my_log10(a, &c)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c;
        }

        /* log(x) = log10(x) */
        if (name[0] == 'l' &&
            name[1] == 'o' &&
            name[2] == 'g' &&
            name[3] == '\0' &&
            *ps->p == ')') {

            if (!my_log10(a, &c)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            ps->p++;
            return c;
        }

        /*
         * Two-argument functions:
         * - log(base, value)
         * - pow(x, y)
         */
        if (*ps->p != ',') {
            ps->error = 1u;
            return 0.0f;
        }

        ps->p++;

        b = f_parse_expression(ps);

        fparser_skip_spaces(ps);

        if (*ps->p != ')') {
            ps->error = 1u;
            return 0.0f;
        }

        ps->p++;

        /* log(base, value) */
        if (name[0] == 'l' &&
            name[1] == 'o' &&
            name[2] == 'g' &&
            name[3] == '\0') {

            if (!my_log(a, b, &c)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            return c;
        }

        /* pow(x, y) */
        if (name[0] == 'p' &&
            name[1] == 'o' &&
            name[2] == 'w' &&
            name[3] == '\0') {

            if (!my_pow(a, b, &c)) {
                ps->domain = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            return c;
        }

        ps->error = 1u;
        return 0.0f;
    }

    ps->error = 1u;
    return 0.0f;
}

static float f_parse_unary(FParser *ps) {
    fparser_skip_spaces(ps);

    if (*ps->p == '+') {
        ps->p++;
        return f_parse_unary(ps);
    }

    if (*ps->p == '-') {
        ps->p++;
        return -f_parse_unary(ps);
    }

    return f_parse_primary(ps);
}

static float f_parse_power(FParser *ps) {
    float lhs = f_parse_unary(ps);

    fparser_skip_spaces(ps);

    if (*ps->p == '^') {
        float rhs;
        float out;

        ps->p++;
        rhs = f_parse_power(ps);

        if (ps->error) {
            return 0.0f;
        }

        if (!my_pow(lhs, rhs, &out)) {
            ps->domain = 1u;
            ps->error = 1u;
            return 0.0f;
        }

        return out;
    }

    return lhs;
}

static float f_parse_term(FParser *ps) {
    float lhs = f_parse_power(ps);

    while (!ps->error) {
        char op;
        float rhs;

        fparser_skip_spaces(ps);

        op = *ps->p;

        if (op != '*' && op != '/') {
            break;
        }

        ps->p++;

        rhs = f_parse_power(ps);

        if (ps->error) {
            return 0.0f;
        }

        if (op == '*') {
            lhs = lhs * rhs;
        } else {
            if (rhs == 0.0f) {
                ps->div0 = 1u;
                ps->error = 1u;
                return 0.0f;
            }

            lhs = lhs / rhs;
        }
    }

    return lhs;
}

static float f_parse_expression(FParser *ps) {
    float lhs = f_parse_term(ps);

    while (!ps->error) {
        char op;
        float rhs;

        fparser_skip_spaces(ps);

        op = *ps->p;

        if (op != '+' && op != '-') {
            break;
        }

        ps->p++;

        rhs = f_parse_term(ps);

        if (ps->error) {
            return 0.0f;
        }

        if (op == '+') {
            lhs += rhs;
        } else {
            lhs -= rhs;
        }
    }

    return lhs;
}

static int eval_float_expression(const char *text, float *out_value) {
    FParser ps;
    float v;

    ps.p = text;
    ps.error = 0u;
    ps.div0 = 0u;
    ps.domain = 0u;

    v = f_parse_expression(&ps);
    fparser_skip_spaces(&ps);

    if (ps.error || *ps.p != '\0') {
        if (ps.div0) {
            str_copy(g_result, "DIV0");
        } else if (ps.domain) {
            str_copy(g_result, "ERROR");
        } else {
            str_copy(g_result, "ERROR");
        }

        return 0;
    }

    *out_value = v;
    return 1;
}

static uint8_t expr_requires_float(const char *text) {
    while (*text) {
        char c = *text;

        if (c == '.' || c == '/' || c == '^' || c == ',') {
            return 1u;
        }

        if (is_alpha_char(c)) {
            return 1u;
        }

        text++;
    }

    return 0u;
}

/* ============================================================
 * XỬ LÝ LỆNH TÍNH TOÁN VÀ VẼ ĐỒ THỊ
 * ============================================================ */
static void calculate_current_expression(void) {
    int32_t ivalue;
    float fvalue;

    if (g_expr_len == 0u) {
        str_copy(g_result, "EMPTY");
        result_refresh_row();
        return;
    }

    // --- KIỂM TRA TỪ KHÓA GRAPH(...) ---
    if (g_expr_len >= 8u &&
        g_expr[0] == 'g' && g_expr[1] == 'r' && g_expr[2] == 'a' &&
        g_expr[3] == 'p' && g_expr[4] == 'h' && g_expr[5] == '(' &&
        g_expr[g_expr_len - 1] == ')') {
        
        char inner_expr[EXPR_MAX_LEN + 1];
        uint8_t len = g_expr_len - 7u;
        for (uint8_t i = 0u; i < len; i++) {
            inner_expr[i] = g_expr[6 + i];
        }
        inner_expr[len] = '\0';
        
        // Tắt lớp hiển thị Text (Xóa chữ graph(x)) để xem đồ thị rõ ràng
        lcd_clear();
        
        // Vẽ đồ họa (Sử dụng Parser số nguyên đã được học cách đọc g_var_x_int)
        draw_graph(inner_expr);
        return; // Thoát hàm ở đây, không in kết quả số ra dòng 4
    }

    // --- TÍNH TOÁN BÌNH THƯỜNG ---
    str_clear(g_result);

    if (expr_requires_float(g_expr)) {
        if (eval_float_expression(g_expr, &fvalue)) {
            float_to_dec_str(fvalue, g_result);
        } else {
            str_copy(g_result, "ERROR");
        }
    } else {
        if (eval_expression(g_expr, &ivalue)) {
            int_to_str(ivalue, g_result);
        } else {
            str_copy(g_result, "ERROR");
        }
    }

    result_refresh_row();
}

/* ============================================================
 * PS/2 translation (Giữ nguyên)
 * ============================================================ */
static uint8_t shift_active(void) {
    return (uint8_t)(g_lshift_pressed || g_rshift_pressed);
}

static int translate_ps2_make_to_char(uint8_t raw, uint8_t is_ext, char *out_char) {
    uint8_t sh = shift_active();

    *out_char = 0;

    if (is_ext) {
        if (raw == 0x4Au) {
            *out_char = '/';
            return 1;
        }

        return 0;
    }

    if (raw == 0x16u) { *out_char = '1'; return 1; }
    if (raw == 0x1Eu) { *out_char = '2'; return 1; }
    if (raw == 0x26u) { *out_char = '3'; return 1; }
    if (raw == 0x25u) { *out_char = '4'; return 1; }
    if (raw == 0x2Eu) { *out_char = '5'; return 1; }
    if (raw == 0x36u) { *out_char = sh ? '^' : '6'; return 1; }
    if (raw == 0x3Du) { *out_char = '7'; return 1; }
    if (raw == 0x3Eu) { *out_char = '8'; return 1; }
    if (raw == 0x46u) { *out_char = '9'; return 1; }
    if (raw == 0x45u) { *out_char = '0'; return 1; }

    if (raw == 0x70u) { *out_char = '0'; return 1; }
    if (raw == 0x69u) { *out_char = '1'; return 1; }
    if (raw == 0x72u) { *out_char = '2'; return 1; }
    if (raw == 0x7Au) { *out_char = '3'; return 1; }
    if (raw == 0x6Bu) { *out_char = '4'; return 1; }
    if (raw == 0x73u) { *out_char = '5'; return 1; }
    if (raw == 0x74u) { *out_char = '6'; return 1; }
    if (raw == 0x6Cu) { *out_char = '7'; return 1; }
    if (raw == 0x75u) { *out_char = '8'; return 1; }
    if (raw == 0x7Du) { *out_char = '9'; return 1; }

    if (raw == 0x79u) { *out_char = '+'; return 1; }
    if (raw == 0x7Bu) { *out_char = '-'; return 1; }
    if (raw == 0x7Cu) { *out_char = '*'; return 1; }
    if (raw == 0x4Au) { *out_char = '/'; return 1; }
    if (raw == 0x71u) { *out_char = '.'; return 1; }
    if (raw == 0x49u) { *out_char = '.'; return 1; }

    if (raw == 0x54u) { *out_char = '('; return 1; }
    if (raw == 0x5Bu) { *out_char = ')'; return 1; }

    if (raw == 0x41u) { *out_char = ','; return 1; }
    if (raw == 0x29u) { *out_char = ' '; return 1; }

    if (raw == 0x1Cu) { *out_char = sh ? 'A' : 'a'; return 1; }
    if (raw == 0x32u) { *out_char = sh ? 'B' : 'b'; return 1; }
    if (raw == 0x21u) { *out_char = sh ? 'C' : 'c'; return 1; }
    if (raw == 0x23u) { *out_char = sh ? 'D' : 'd'; return 1; }
    if (raw == 0x24u) { *out_char = sh ? 'E' : 'e'; return 1; }
    if (raw == 0x2Bu) { *out_char = sh ? 'F' : 'f'; return 1; }
    if (raw == 0x34u) { *out_char = sh ? 'G' : 'g'; return 1; }
    if (raw == 0x33u) { *out_char = sh ? 'H' : 'h'; return 1; }
    if (raw == 0x43u) { *out_char = sh ? 'I' : 'i'; return 1; }
    if (raw == 0x3Bu) { *out_char = sh ? 'J' : 'j'; return 1; }
    if (raw == 0x42u) { *out_char = sh ? 'K' : 'k'; return 1; }
    if (raw == 0x4Bu) { *out_char = sh ? 'L' : 'l'; return 1; }
    if (raw == 0x3Au) { *out_char = sh ? 'M' : 'm'; return 1; }
    if (raw == 0x31u) { *out_char = sh ? 'N' : 'n'; return 1; }
    if (raw == 0x44u) { *out_char = sh ? 'O' : 'o'; return 1; }
    if (raw == 0x4Du) { *out_char = sh ? 'P' : 'p'; return 1; }
    if (raw == 0x15u) { *out_char = sh ? 'Q' : 'q'; return 1; }
    if (raw == 0x2Du) { *out_char = sh ? 'R' : 'r'; return 1; }
    if (raw == 0x1Bu) { *out_char = sh ? 'S' : 's'; return 1; }
    if (raw == 0x2Cu) { *out_char = sh ? 'T' : 't'; return 1; }
    if (raw == 0x3Cu) { *out_char = sh ? 'U' : 'u'; return 1; }
    if (raw == 0x2Au) { *out_char = sh ? 'V' : 'v'; return 1; }
    if (raw == 0x1Du) { *out_char = sh ? 'W' : 'w'; return 1; }
    if (raw == 0x22u) { *out_char = sh ? 'X' : 'x'; return 1; }
    if (raw == 0x35u) { *out_char = sh ? 'Y' : 'y'; return 1; }
    if (raw == 0x1Au) { *out_char = sh ? 'Z' : 'z'; return 1; }

    return 0;
}

static void handle_ps2_complete_code(uint8_t raw, uint8_t error) {
    uint8_t is_break;
    uint8_t is_ext;
    char out_char;

    REG_LEDR = ((uint32_t)raw)
             | ((uint32_t)1u << 8)
             | ((uint32_t)error << 9)
             | ((uint32_t)g_prefix_f0 << 10)
             | ((uint32_t)g_prefix_e0 << 11)
             | ((uint32_t)g_lshift_pressed << 12)
             | ((uint32_t)g_rshift_pressed << 13);

    if (error) {
        g_prefix_f0 = 0u;
        g_prefix_e0 = 0u;
        return;
    }

    if (raw == 0xE0u) {
        g_prefix_e0 = 1u;
        return;
    }

    if (raw == 0xF0u) {
        g_prefix_f0 = 1u;
        return;
    }

    is_break = g_prefix_f0;
    is_ext   = g_prefix_e0;

    g_prefix_f0 = 0u;
    g_prefix_e0 = 0u;

    if (!is_ext && raw == 0x12u) {
        g_lshift_pressed = is_break ? 0u : 1u;
        return;
    }

    if (!is_ext && raw == 0x59u) {
        g_rshift_pressed = is_break ? 0u : 1u;
        return;
    }

    // THOÁT ĐỒ THỊ AN TOÀN BẰNG BẤT KỲ NÚT NÀO MÀ KHÔNG BỊ TREO MÁY
    if (g_is_graphic_mode) {
        if (is_break) return; // Nếu đang nhả tay thì bỏ qua để chống treo
        g_is_graphic_mode = 0u;
        lcd_write_cmd(0x34u); // Tắt Extended mode (Tắt GDRAM)
        lcd_write_cmd(0x30u); // Chuyển về Basic Mode
        lcd_clear();          // Xóa rác đồ thị cũ
        input_refresh_row();  // In lại màn hình text
        result_refresh_row();
        return; 
    }

    // Các xử lý ở dưới chỉ nhận phím khi nhấn vào (Make Code)
    if (is_break) {
        return;
    }

    if (is_ext && raw == 0x6Bu) { 
        input_cursor_left();
        return;
    }

    if (is_ext && raw == 0x74u) { 
        input_cursor_right();
        return;
    }

    if (is_ext && raw == 0x71u) { 
        input_delete_at_cursor();
        return;
    }

    if (is_ext && raw == 0x6Cu) { 
        input_cursor_home();
        return;
    }

    if (is_ext && raw == 0x69u) { 
        input_cursor_end();
        return;
    }

    if (!is_ext && raw == 0x5Au) {
        calculate_current_expression();
        return;
    }

    if (!is_ext && raw == 0x66u) {
        input_backspace();
        return;
    }

    if (!is_ext && raw == 0x76u) {
        input_clear();
        return;
    }

    if (translate_ps2_make_to_char(raw, is_ext, &out_char)) {
        input_append_char(out_char);
    }
}

static void ps2_reset_state(void) {
    g_prefix_f0 = 0u;
    g_prefix_e0 = 0u;
    g_lshift_pressed = 0u;
    g_rshift_pressed = 0u;
}

/* ============================================================
 * MAIN
 * ============================================================ */
int main(void) {
    uint32_t ps2_reg;
    uint8_t error;
    uint8_t raw;
    uint8_t prev_raw = 0u;
    uint8_t prev_error = 0u;

    ps2_reset_state();

    lcd_hard_init();
    screen_clear_all();
    REG_LEDR = 0u;

    ps2_reg = REG_PS2;
    prev_raw   = (uint8_t)(ps2_reg & PS2_DATA_MASK);
    prev_error = (uint8_t)((ps2_reg & PS2_ERROR_MASK) ? 1u : 0u);

    while (1) {
        ps2_reg = REG_PS2;

        raw   = (uint8_t)(ps2_reg & PS2_DATA_MASK);
        error = (uint8_t)((ps2_reg & PS2_ERROR_MASK) ? 1u : 0u);

        if (!error) {
            if ((raw != prev_raw) || (error != prev_error)) {
                handle_ps2_complete_code(raw, error);
            }
        } else {
            g_prefix_f0 = 0u;
            g_prefix_e0 = 0u;
        }

        prev_raw = raw;
        prev_error = error;
    }

    return 0;
}

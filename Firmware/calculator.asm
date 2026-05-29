
calculator.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
       0:	00010117          	auipc	x2,0x10
       4:	00010113          	addi	x2,x2,0 # 10000 <_stack_ptr>
       8:	00004097          	auipc	x1,0x4
       c:	cf0080e7          	jalr	x1,-784(x1) # 3cf8 <main>

00000010 <_exit>:
      10:	0000006f          	jal	x0,10 <_exit>

00000014 <delay_ms>:
      14:	00001737          	lui	x14,0x1
      18:	ff010113          	addi	x2,x2,-16
      1c:	38870713          	addi	x14,x14,904 # 1388 <f_parse_unary+0x554>
      20:	00e12623          	sw	x14,12(x2)
      24:	00c12783          	lw	x15,12(x2)
      28:	00f05c63          	bge	x0,x15,40 <delay_ms+0x2c>
      2c:	00c12783          	lw	x15,12(x2)
      30:	fff78793          	addi	x15,x15,-1
      34:	00f12623          	sw	x15,12(x2)
      38:	00c12783          	lw	x15,12(x2)
      3c:	fef048e3          	blt	x0,x15,2c <delay_ms+0x18>
      40:	fff50513          	addi	x10,x10,-1
      44:	fc051ee3          	bne	x10,x0,20 <delay_ms+0xc>
      48:	01010113          	addi	x2,x2,16
      4c:	00008067          	jalr	x0,0(x1)

00000050 <lcd_pulse_en>:
      50:	100047b7          	lui	x15,0x10004
      54:	40056713          	ori	x14,x10,1024
      58:	00e7a023          	sw	x14,0(x15) # 10004000 <_stack_ptr+0xfff4000>
      5c:	ff010113          	addi	x2,x2,-16
      60:	00a00793          	addi	x15,x0,10
      64:	00f12623          	sw	x15,12(x2)
      68:	00c12783          	lw	x15,12(x2)
      6c:	00f05c63          	bge	x0,x15,84 <lcd_pulse_en+0x34>
      70:	00c12783          	lw	x15,12(x2)
      74:	fff78793          	addi	x15,x15,-1
      78:	00f12623          	sw	x15,12(x2)
      7c:	00c12783          	lw	x15,12(x2)
      80:	fef048e3          	blt	x0,x15,70 <lcd_pulse_en+0x20>
      84:	100047b7          	lui	x15,0x10004
      88:	00a7a023          	sw	x10,0(x15) # 10004000 <_stack_ptr+0xfff4000>
      8c:	16800793          	addi	x15,x0,360
      90:	00f12423          	sw	x15,8(x2)
      94:	00812783          	lw	x15,8(x2)
      98:	00f05c63          	bge	x0,x15,b0 <lcd_pulse_en+0x60>
      9c:	00812783          	lw	x15,8(x2)
      a0:	fff78793          	addi	x15,x15,-1
      a4:	00f12423          	sw	x15,8(x2)
      a8:	00812783          	lw	x15,8(x2)
      ac:	fef048e3          	blt	x0,x15,9c <lcd_pulse_en+0x4c>
      b0:	01010113          	addi	x2,x2,16
      b4:	00008067          	jalr	x0,0(x1)

000000b8 <reduce_angle_to_pi>:
      b8:	000047b7          	lui	x15,0x4
      bc:	c807a787          	flw	f15,-896(x15) # 3c80 <__clz_tab+0x100>
      c0:	a0a79753          	flt.s	x14,f15,f10
      c4:	04070463          	beq	x14,x0,10c <reduce_angle_to_pi+0x54>
      c8:	00004737          	lui	x14,0x4
      cc:	c8472787          	flw	f15,-892(x14) # 3c84 <__clz_tab+0x104>
      d0:	00004737          	lui	x14,0x4
      d4:	c8872707          	flw	f14,-888(x14) # 3c88 <__clz_tab+0x108>
      d8:	10f577d3          	fmul.s	f15,f10,f15
      dc:	00e7f7d3          	fadd.s	f15,f15,f14
      e0:	c0079753          	fcvt.w.s	x14,f15,rtz
      e4:	d00777d3          	fcvt.s.w	f15,x14
      e8:	00004737          	lui	x14,0x4
      ec:	c9072707          	flw	f14,-880(x14) # 3c90 <__clz_tab+0x110>
      f0:	c807a687          	flw	f13,-896(x15)
      f4:	10e7f7d3          	fmul.s	f15,f15,f14
      f8:	08f57553          	fsub.s	f10,f10,f15
      fc:	a0a697d3          	flt.s	x15,f13,f10
     100:	02078e63          	beq	x15,x0,13c <reduce_angle_to_pi+0x84>
     104:	08e57553          	fsub.s	f10,f10,f14
     108:	00008067          	jalr	x0,0(x1)
     10c:	00004737          	lui	x14,0x4
     110:	c8c72787          	flw	f15,-884(x14) # 3c8c <__clz_tab+0x10c>
     114:	a0f51753          	flt.s	x14,f10,f15
     118:	02070c63          	beq	x14,x0,150 <reduce_angle_to_pi+0x98>
     11c:	00004737          	lui	x14,0x4
     120:	c8472787          	flw	f15,-892(x14) # 3c84 <__clz_tab+0x104>
     124:	00004737          	lui	x14,0x4
     128:	c8872707          	flw	f14,-888(x14) # 3c88 <__clz_tab+0x108>
     12c:	10f577d3          	fmul.s	f15,f10,f15
     130:	08e7f7d3          	fsub.s	f15,f15,f14
     134:	c0079753          	fcvt.w.s	x14,f15,rtz
     138:	fadff06f          	jal	x0,e4 <reduce_angle_to_pi+0x2c>
     13c:	000047b7          	lui	x15,0x4
     140:	c8c7a787          	flw	f15,-884(x15) # 3c8c <__clz_tab+0x10c>
     144:	a0f517d3          	flt.s	x15,f10,f15
     148:	00078463          	beq	x15,x0,150 <reduce_angle_to_pi+0x98>
     14c:	00e57553          	fadd.s	f10,f10,f14
     150:	00008067          	jalr	x0,0(x1)

00000154 <my_atan_poly>:
     154:	10a57753          	fmul.s	f14,f10,f10
     158:	000047b7          	lui	x15,0x4
     15c:	c947a787          	flw	f15,-876(x15) # 3c94 <__clz_tab+0x114>
     160:	000047b7          	lui	x15,0x4
     164:	c987a687          	flw	f13,-872(x15) # 3c98 <__clz_tab+0x118>
     168:	10f777d3          	fmul.s	f15,f14,f15
     16c:	000047b7          	lui	x15,0x4
     170:	08d7f7d3          	fsub.s	f15,f15,f13
     174:	c9c7a687          	flw	f13,-868(x15) # 3c9c <__clz_tab+0x11c>
     178:	000047b7          	lui	x15,0x4
     17c:	10e7f7d3          	fmul.s	f15,f15,f14
     180:	00d7f7d3          	fadd.s	f15,f15,f13
     184:	ca07a687          	flw	f13,-864(x15) # 3ca0 <__clz_tab+0x120>
     188:	000047b7          	lui	x15,0x4
     18c:	10e7f7d3          	fmul.s	f15,f15,f14
     190:	08d7f7d3          	fsub.s	f15,f15,f13
     194:	ca47a687          	flw	f13,-860(x15) # 3ca4 <__clz_tab+0x124>
     198:	000047b7          	lui	x15,0x4
     19c:	10e7f7d3          	fmul.s	f15,f15,f14
     1a0:	00d7f7d3          	fadd.s	f15,f15,f13
     1a4:	ca87a687          	flw	f13,-856(x15) # 3ca8 <__clz_tab+0x128>
     1a8:	000047b7          	lui	x15,0x4
     1ac:	10e7f7d3          	fmul.s	f15,f15,f14
     1b0:	08d7f7d3          	fsub.s	f15,f15,f13
     1b4:	cac7a687          	flw	f13,-852(x15) # 3cac <__clz_tab+0x12c>
     1b8:	000047b7          	lui	x15,0x4
     1bc:	10e7f7d3          	fmul.s	f15,f15,f14
     1c0:	00d7f7d3          	fadd.s	f15,f15,f13
     1c4:	cb07a687          	flw	f13,-848(x15) # 3cb0 <__clz_tab+0x130>
     1c8:	000047b7          	lui	x15,0x4
     1cc:	10e7f7d3          	fmul.s	f15,f15,f14
     1d0:	08d7f7d3          	fsub.s	f15,f15,f13
     1d4:	cb47a687          	flw	f13,-844(x15) # 3cb4 <__clz_tab+0x134>
     1d8:	000047b7          	lui	x15,0x4
     1dc:	10e7f7d3          	fmul.s	f15,f15,f14
     1e0:	00d7f7d3          	fadd.s	f15,f15,f13
     1e4:	cb87a687          	flw	f13,-840(x15) # 3cb8 <__clz_tab+0x138>
     1e8:	000047b7          	lui	x15,0x4
     1ec:	10e7f7d3          	fmul.s	f15,f15,f14
     1f0:	08d7f7d3          	fsub.s	f15,f15,f13
     1f4:	cbc7a687          	flw	f13,-836(x15) # 3cbc <__clz_tab+0x13c>
     1f8:	000047b7          	lui	x15,0x4
     1fc:	10e7f7d3          	fmul.s	f15,f15,f14
     200:	00d7f7d3          	fadd.s	f15,f15,f13
     204:	cc07a687          	flw	f13,-832(x15) # 3cc0 <__clz_tab+0x140>
     208:	000047b7          	lui	x15,0x4
     20c:	10e7f7d3          	fmul.s	f15,f15,f14
     210:	08d7f7d3          	fsub.s	f15,f15,f13
     214:	10e7f7d3          	fmul.s	f15,f15,f14
     218:	cc47a707          	flw	f14,-828(x15) # 3cc4 <__clz_tab+0x144>
     21c:	00e7f7d3          	fadd.s	f15,f15,f14
     220:	10a7f553          	fmul.s	f10,f15,f10
     224:	00008067          	jalr	x0,0(x1)

00000228 <my_atan>:
     228:	f00007d3          	fmv.w.x	f15,x0
     22c:	ff010113          	addi	x2,x2,-16
     230:	00812423          	sw	x8,8(x2)
     234:	a0f517d3          	flt.s	x15,f10,f15
     238:	00112623          	sw	x1,12(x2)
     23c:	00000413          	addi	x8,x0,0
     240:	00078663          	beq	x15,x0,24c <my_atan+0x24>
     244:	20a51553          	fsgnjn.s	f10,f10,f10
     248:	00100413          	addi	x8,x0,1
     24c:	000047b7          	lui	x15,0x4
     250:	cc47a787          	flw	f15,-828(x15) # 3cc4 <__clz_tab+0x144>
     254:	a0a797d3          	flt.s	x15,f15,f10
     258:	06078a63          	beq	x15,x0,2cc <my_atan+0xa4>
     25c:	18a7f553          	fdiv.s	f10,f15,f10
     260:	000047b7          	lui	x15,0x4
     264:	cc87a707          	flw	f14,-824(x15) # 3cc8 <__clz_tab+0x148>
     268:	a0a717d3          	flt.s	x15,f14,f10
     26c:	04078463          	beq	x15,x0,2b4 <my_atan+0x8c>
     270:	08f57753          	fsub.s	f14,f10,f15
     274:	00f57553          	fadd.s	f10,f10,f15
     278:	18a77553          	fdiv.s	f10,f14,f10
     27c:	00000097          	auipc	x1,0x0
     280:	ed8080e7          	jalr	x1,-296(x1) # 154 <my_atan_poly>
     284:	000047b7          	lui	x15,0x4
     288:	ccc7a787          	flw	f15,-820(x15) # 3ccc <__clz_tab+0x14c>
     28c:	000047b7          	lui	x15,0x4
     290:	00f577d3          	fadd.s	f15,f10,f15
     294:	cd07a507          	flw	f10,-816(x15) # 3cd0 <__clz_tab+0x150>
     298:	08f57553          	fsub.s	f10,f10,f15
     29c:	00040463          	beq	x8,x0,2a4 <my_atan+0x7c>
     2a0:	20a51553          	fsgnjn.s	f10,f10,f10
     2a4:	00c12083          	lw	x1,12(x2)
     2a8:	00812403          	lw	x8,8(x2)
     2ac:	01010113          	addi	x2,x2,16
     2b0:	00008067          	jalr	x0,0(x1)
     2b4:	00000097          	auipc	x1,0x0
     2b8:	ea0080e7          	jalr	x1,-352(x1) # 154 <my_atan_poly>
     2bc:	000047b7          	lui	x15,0x4
     2c0:	cd07a787          	flw	f15,-816(x15) # 3cd0 <__clz_tab+0x150>
     2c4:	08a7f553          	fsub.s	f10,f15,f10
     2c8:	fd5ff06f          	jal	x0,29c <my_atan+0x74>
     2cc:	000047b7          	lui	x15,0x4
     2d0:	cc87a707          	flw	f14,-824(x15) # 3cc8 <__clz_tab+0x148>
     2d4:	a0a717d3          	flt.s	x15,f14,f10
     2d8:	02078463          	beq	x15,x0,300 <my_atan+0xd8>
     2dc:	08f57753          	fsub.s	f14,f10,f15
     2e0:	00f57553          	fadd.s	f10,f10,f15
     2e4:	18a77553          	fdiv.s	f10,f14,f10
     2e8:	00000097          	auipc	x1,0x0
     2ec:	e6c080e7          	jalr	x1,-404(x1) # 154 <my_atan_poly>
     2f0:	000047b7          	lui	x15,0x4
     2f4:	ccc7a787          	flw	f15,-820(x15) # 3ccc <__clz_tab+0x14c>
     2f8:	00f57553          	fadd.s	f10,f10,f15
     2fc:	fa1ff06f          	jal	x0,29c <my_atan+0x74>
     300:	00000097          	auipc	x1,0x0
     304:	e54080e7          	jalr	x1,-428(x1) # 154 <my_atan_poly>
     308:	f95ff06f          	jal	x0,29c <my_atan+0x74>

0000030c <my_asin.part.0>:
     30c:	f00007d3          	fmv.w.x	f15,x0
     310:	ff010113          	addi	x2,x2,-16
     314:	00112623          	sw	x1,12(x2)
     318:	a0f517d3          	flt.s	x15,f10,f15
     31c:	00812423          	sw	x8,8(x2)
     320:	0a079263          	bne	x15,x0,3c4 <my_asin.part.0+0xb8>
     324:	000047b7          	lui	x15,0x4
     328:	cc47a787          	flw	f15,-828(x15) # 3cc4 <__clz_tab+0x144>
     32c:	00000413          	addi	x8,x0,0
     330:	a0a78753          	fle.s	x14,f15,f10
     334:	06071c63          	bne	x14,x0,3ac <my_asin.part.0+0xa0>
     338:	cc47a707          	flw	f14,-828(x15)
     33c:	000047b7          	lui	x15,0x4
     340:	c887a787          	flw	f15,-888(x15) # 3c88 <__clz_tab+0x108>
     344:	00e576d3          	fadd.s	f13,f10,f14
     348:	a0a797d3          	flt.s	x15,f15,f10
     34c:	08a777d3          	fsub.s	f15,f14,f10
     350:	02078e63          	beq	x15,x0,38c <my_asin.part.0+0x80>
     354:	18d7f553          	fdiv.s	f10,f15,f13
     358:	58057553          	fsqrt.s	f10,f10
     35c:	00000097          	auipc	x1,0x0
     360:	ecc080e7          	jalr	x1,-308(x1) # 228 <my_atan>
     364:	00a577d3          	fadd.s	f15,f10,f10
     368:	000047b7          	lui	x15,0x4
     36c:	cd07a507          	flw	f10,-816(x15) # 3cd0 <__clz_tab+0x150>
     370:	08f57553          	fsub.s	f10,f10,f15
     374:	00040463          	beq	x8,x0,37c <my_asin.part.0+0x70>
     378:	20a51553          	fsgnjn.s	f10,f10,f10
     37c:	00c12083          	lw	x1,12(x2)
     380:	00812403          	lw	x8,8(x2)
     384:	01010113          	addi	x2,x2,16
     388:	00008067          	jalr	x0,0(x1)
     38c:	10d7f7d3          	fmul.s	f15,f15,f13
     390:	5807f7d3          	fsqrt.s	f15,f15
     394:	00e7f7d3          	fadd.s	f15,f15,f14
     398:	18f57553          	fdiv.s	f10,f10,f15
     39c:	00000097          	auipc	x1,0x0
     3a0:	e8c080e7          	jalr	x1,-372(x1) # 228 <my_atan>
     3a4:	00a57553          	fadd.s	f10,f10,f10
     3a8:	fcdff06f          	jal	x0,374 <my_asin.part.0+0x68>
     3ac:	00c12083          	lw	x1,12(x2)
     3b0:	00812403          	lw	x8,8(x2)
     3b4:	000047b7          	lui	x15,0x4
     3b8:	cd07a507          	flw	f10,-816(x15) # 3cd0 <__clz_tab+0x150>
     3bc:	01010113          	addi	x2,x2,16
     3c0:	00008067          	jalr	x0,0(x1)
     3c4:	000047b7          	lui	x15,0x4
     3c8:	cd87a787          	flw	f15,-808(x15) # 3cd8 <__clz_tab+0x158>
     3cc:	a0f507d3          	fle.s	x15,f10,f15
     3d0:	00079a63          	bne	x15,x0,3e4 <my_asin.part.0+0xd8>
     3d4:	20a51553          	fsgnjn.s	f10,f10,f10
     3d8:	00100413          	addi	x8,x0,1
     3dc:	000047b7          	lui	x15,0x4
     3e0:	f59ff06f          	jal	x0,338 <my_asin.part.0+0x2c>
     3e4:	00c12083          	lw	x1,12(x2)
     3e8:	00812403          	lw	x8,8(x2)
     3ec:	000047b7          	lui	x15,0x4
     3f0:	cd47a507          	flw	f10,-812(x15) # 3cd4 <__clz_tab+0x154>
     3f4:	01010113          	addi	x2,x2,16
     3f8:	00008067          	jalr	x0,0(x1)

000003fc <lcd_write_line_padded>:
     3fc:	fe010113          	addi	x2,x2,-32
     400:	00812c23          	sw	x8,24(x2)
     404:	000017b7          	lui	x15,0x1
     408:	00112e23          	sw	x1,28(x2)
     40c:	00912a23          	sw	x9,20(x2)
     410:	01212823          	sw	x18,16(x2)
     414:	01312623          	sw	x19,12(x2)
     418:	00058413          	addi	x8,x11,0
     41c:	88078793          	addi	x15,x15,-1920 # 880 <parse_factor+0x144>
     420:	02050263          	beq	x10,x0,444 <lcd_write_line_padded+0x48>
     424:	000017b7          	lui	x15,0x1
     428:	00100713          	addi	x14,x0,1
     42c:	89078793          	addi	x15,x15,-1904 # 890 <parse_factor+0x154>
     430:	00e50a63          	beq	x10,x14,444 <lcd_write_line_padded+0x48>
     434:	000017b7          	lui	x15,0x1
     438:	00200713          	addi	x14,x0,2
     43c:	89878793          	addi	x15,x15,-1896 # 898 <parse_factor+0x15c>
     440:	06e50063          	beq	x10,x14,4a0 <lcd_write_line_padded+0xa4>
     444:	10004737          	lui	x14,0x10004
     448:	00f72023          	sw	x15,0(x14) # 10004000 <_stack_ptr+0xfff4000>
     44c:	00078513          	addi	x10,x15,0
     450:	000014b7          	lui	x9,0x1
     454:	00000097          	auipc	x1,0x0
     458:	bfc080e7          	jalr	x1,-1028(x1) # 50 <lcd_pulse_en>
     45c:	01040993          	addi	x19,x8,16
     460:	90048493          	addi	x9,x9,-1792 # 900 <parse_factor+0x1c4>
     464:	10004937          	lui	x18,0x10004
     468:	00044503          	lbu	x10,0(x8)
     46c:	00140413          	addi	x8,x8,1
     470:	00956533          	or	x10,x10,x9
     474:	00a92023          	sw	x10,0(x18) # 10004000 <_stack_ptr+0xfff4000>
     478:	00000097          	auipc	x1,0x0
     47c:	bd8080e7          	jalr	x1,-1064(x1) # 50 <lcd_pulse_en>
     480:	ff3414e3          	bne	x8,x19,468 <lcd_write_line_padded+0x6c>
     484:	01c12083          	lw	x1,28(x2)
     488:	01812403          	lw	x8,24(x2)
     48c:	01412483          	lw	x9,20(x2)
     490:	01012903          	lw	x18,16(x2)
     494:	00c12983          	lw	x19,12(x2)
     498:	02010113          	addi	x2,x2,32
     49c:	00008067          	jalr	x0,0(x1)
     4a0:	000017b7          	lui	x15,0x1
     4a4:	88878793          	addi	x15,x15,-1912 # 888 <parse_factor+0x14c>
     4a8:	f9dff06f          	jal	x0,444 <lcd_write_line_padded+0x48>

000004ac <my_log10>:
     4ac:	f00007d3          	fmv.w.x	f15,x0
     4b0:	00050793          	addi	x15,x10,0
     4b4:	a0f50753          	fle.s	x14,f10,f15
     4b8:	06071263          	bne	x14,x0,51c <my_log10+0x70>
     4bc:	00004737          	lui	x14,0x4
     4c0:	cc472707          	flw	f14,-828(x14) # 3cc4 <__clz_tab+0x144>
     4c4:	00004737          	lui	x14,0x4
     4c8:	cd872687          	flw	f13,-808(x14) # 3cd8 <__clz_tab+0x158>
     4cc:	08e577d3          	fsub.s	f15,f10,f14
     4d0:	00e57553          	fadd.s	f10,f10,f14
     4d4:	00000513          	addi	x10,x0,0
     4d8:	18a7f7d3          	fdiv.s	f15,f15,f10
     4dc:	a0d78753          	fle.s	x14,f15,f13
     4e0:	04071063          	bne	x14,x0,520 <my_log10+0x74>
     4e4:	a0f70753          	fle.s	x14,f14,f15
     4e8:	02071c63          	bne	x14,x0,520 <my_log10+0x74>
     4ec:	00004737          	lui	x14,0x4
     4f0:	cdc72707          	flw	f14,-804(x14) # 3cdc <__clz_tab+0x15c>
     4f4:	a0f70753          	fle.s	x14,f14,f15
     4f8:	02070463          	beq	x14,x0,520 <my_log10+0x74>
     4fc:	800787d3          	.insn	4, 0x800787d3
     500:	00f7f7d3          	fadd.s	f15,f15,f15
     504:	00004737          	lui	x14,0x4
     508:	ce072707          	flw	f14,-800(x14) # 3ce0 <__clz_tab+0x160>
     50c:	00100513          	addi	x10,x0,1
     510:	10e7f7d3          	fmul.s	f15,f15,f14
     514:	00f7a027          	fsw	f15,0(x15)
     518:	00008067          	jalr	x0,0(x1)
     51c:	00000513          	addi	x10,x0,0
     520:	00008067          	jalr	x0,0(x1)

00000524 <result_refresh_row>:
     524:	fe010113          	addi	x2,x2,-32
     528:	00812c23          	sw	x8,24(x2)
     52c:	00005437          	lui	x8,0x5
     530:	00912a23          	sw	x9,20(x2)
     534:	00112e23          	sw	x1,28(x2)
     538:	01212823          	sw	x18,16(x2)
     53c:	01312623          	sw	x19,12(x2)
     540:	62840413          	addi	x8,x8,1576 # 5628 <g_screen>
     544:	202027b7          	lui	x15,0x20202
     548:	04044703          	lbu	x14,64(x8)
     54c:	02078793          	addi	x15,x15,32 # 20202020 <_stack_ptr+0x201f2020>
     550:	000054b7          	lui	x9,0x5
     554:	02f42823          	sw	x15,48(x8)
     558:	02f42a23          	sw	x15,52(x8)
     55c:	02f42c23          	sw	x15,56(x8)
     560:	02f42e23          	sw	x15,60(x8)
     564:	66848493          	addi	x9,x9,1640 # 5668 <g_result>
     568:	04070a63          	beq	x14,x0,5bc <result_refresh_row+0x98>
     56c:	04040493          	addi	x9,x8,64
     570:	00048713          	addi	x14,x9,0
     574:	00048793          	addi	x15,x9,0
     578:	0017c603          	lbu	x12,1(x15)
     57c:	00078693          	addi	x13,x15,0
     580:	00178793          	addi	x15,x15,1
     584:	fe061ae3          	bne	x12,x0,578 <result_refresh_row+0x54>
     588:	409686b3          	sub	x13,x13,x9
     58c:	00168693          	addi	x13,x13,1
     590:	01000793          	addi	x15,x0,16
     594:	08d7e463          	bltu	x15,x13,61c <result_refresh_row+0xf8>
     598:	0ff6f693          	andi	x13,x13,255
     59c:	00000793          	addi	x15,x0,0
     5a0:	00074583          	lbu	x11,0(x14)
     5a4:	00f40633          	add	x12,x8,x15
     5a8:	00178793          	addi	x15,x15,1
     5ac:	02b60823          	sb	x11,48(x12)
     5b0:	0ff7f613          	andi	x12,x15,255
     5b4:	00170713          	addi	x14,x14,1
     5b8:	fed664e3          	bltu	x12,x13,5a0 <result_refresh_row+0x7c>
     5bc:	00001537          	lui	x10,0x1
     5c0:	89850513          	addi	x10,x10,-1896 # 898 <parse_factor+0x15c>
     5c4:	100047b7          	lui	x15,0x10004
     5c8:	00a7a023          	sw	x10,0(x15) # 10004000 <_stack_ptr+0xfff4000>
     5cc:	00001937          	lui	x18,0x1
     5d0:	00000097          	auipc	x1,0x0
     5d4:	a80080e7          	jalr	x1,-1408(x1) # 50 <lcd_pulse_en>
     5d8:	03040413          	addi	x8,x8,48
     5dc:	90090913          	addi	x18,x18,-1792 # 900 <parse_factor+0x1c4>
     5e0:	100049b7          	lui	x19,0x10004
     5e4:	00044503          	lbu	x10,0(x8)
     5e8:	00140413          	addi	x8,x8,1
     5ec:	01256533          	or	x10,x10,x18
     5f0:	00a9a023          	sw	x10,0(x19) # 10004000 <_stack_ptr+0xfff4000>
     5f4:	00000097          	auipc	x1,0x0
     5f8:	a5c080e7          	jalr	x1,-1444(x1) # 50 <lcd_pulse_en>
     5fc:	fe8494e3          	bne	x9,x8,5e4 <result_refresh_row+0xc0>
     600:	01c12083          	lw	x1,28(x2)
     604:	01812403          	lw	x8,24(x2)
     608:	01412483          	lw	x9,20(x2)
     60c:	01012903          	lw	x18,16(x2)
     610:	00c12983          	lw	x19,12(x2)
     614:	02010113          	addi	x2,x2,32
     618:	00008067          	jalr	x0,0(x1)
     61c:	01000693          	addi	x13,x0,16
     620:	f79ff06f          	jal	x0,598 <result_refresh_row+0x74>

00000624 <input_refresh_row>:
     624:	fe010113          	addi	x2,x2,-32
     628:	00812c23          	sw	x8,24(x2)
     62c:	00006737          	lui	x14,0x6
     630:	202027b7          	lui	x15,0x20202
     634:	00005437          	lui	x8,0x5
     638:	02078793          	addi	x15,x15,32 # 20202020 <_stack_ptr+0x201f2020>
     63c:	00112e23          	sw	x1,28(x2)
     640:	00912a23          	sw	x9,20(x2)
     644:	01212823          	sw	x18,16(x2)
     648:	01312623          	sw	x19,12(x2)
     64c:	62840413          	addi	x8,x8,1576 # 5628 <g_screen>
     650:	aaa74683          	lbu	x13,-1366(x14) # 5aaa <g_expr_len>
     654:	00006737          	lui	x14,0x6
     658:	aa974603          	lbu	x12,-1367(x14) # 5aa9 <g_cursor_pos>
     65c:	00f42023          	sw	x15,0(x8)
     660:	00f42223          	sw	x15,4(x8)
     664:	00f42423          	sw	x15,8(x8)
     668:	00f42623          	sw	x15,12(x8)
     66c:	00000713          	addi	x14,x0,0
     670:	00000793          	addi	x15,x0,0
     674:	00f00593          	addi	x11,x0,15
     678:	07c00893          	addi	x17,x0,124
     67c:	08f60863          	beq	x12,x15,70c <input_refresh_row+0xe8>
     680:	02d7f063          	bgeu	x15,x13,6a0 <input_refresh_row+0x7c>
     684:	0ae5e063          	bltu	x11,x14,724 <input_refresh_row+0x100>
     688:	00f40533          	add	x10,x8,x15
     68c:	06454803          	lbu	x16,100(x10)
     690:	00e40533          	add	x10,x8,x14
     694:	00170713          	addi	x14,x14,1
     698:	01050023          	sb	x16,0(x10)
     69c:	0ff77713          	andi	x14,x14,255
     6a0:	00178793          	addi	x15,x15,1
     6a4:	0ff7f793          	andi	x15,x15,255
     6a8:	fcf6fae3          	bgeu	x13,x15,67c <input_refresh_row+0x58>
     6ac:	00001537          	lui	x10,0x1
     6b0:	88050513          	addi	x10,x10,-1920 # 880 <parse_factor+0x144>
     6b4:	100047b7          	lui	x15,0x10004
     6b8:	00a7a023          	sw	x10,0(x15) # 10004000 <_stack_ptr+0xfff4000>
     6bc:	000014b7          	lui	x9,0x1
     6c0:	00000097          	auipc	x1,0x0
     6c4:	990080e7          	jalr	x1,-1648(x1) # 50 <lcd_pulse_en>
     6c8:	01040993          	addi	x19,x8,16
     6cc:	90048493          	addi	x9,x9,-1792 # 900 <parse_factor+0x1c4>
     6d0:	10004937          	lui	x18,0x10004
     6d4:	00044503          	lbu	x10,0(x8)
     6d8:	00140413          	addi	x8,x8,1
     6dc:	00956533          	or	x10,x10,x9
     6e0:	00a92023          	sw	x10,0(x18) # 10004000 <_stack_ptr+0xfff4000>
     6e4:	00000097          	auipc	x1,0x0
     6e8:	96c080e7          	jalr	x1,-1684(x1) # 50 <lcd_pulse_en>
     6ec:	fe8994e3          	bne	x19,x8,6d4 <input_refresh_row+0xb0>
     6f0:	01c12083          	lw	x1,28(x2)
     6f4:	01812403          	lw	x8,24(x2)
     6f8:	01412483          	lw	x9,20(x2)
     6fc:	01012903          	lw	x18,16(x2)
     700:	00c12983          	lw	x19,12(x2)
     704:	02010113          	addi	x2,x2,32
     708:	00008067          	jalr	x0,0(x1)
     70c:	f8e5eae3          	bltu	x11,x14,6a0 <input_refresh_row+0x7c>
     710:	00e40533          	add	x10,x8,x14
     714:	00170713          	addi	x14,x14,1
     718:	01150023          	sb	x17,0(x10)
     71c:	0ff77713          	andi	x14,x14,255
     720:	f61ff06f          	jal	x0,680 <input_refresh_row+0x5c>
     724:	00178793          	addi	x15,x15,1
     728:	0ff7f793          	andi	x15,x15,255
     72c:	f8f6e0e3          	bltu	x13,x15,6ac <input_refresh_row+0x88>
     730:	f6f608e3          	beq	x12,x15,6a0 <input_refresh_row+0x7c>
     734:	fed7e8e3          	bltu	x15,x13,724 <input_refresh_row+0x100>
     738:	f69ff06f          	jal	x0,6a0 <input_refresh_row+0x7c>

0000073c <parse_factor>:
     73c:	ff010113          	addi	x2,x2,-16
     740:	00812423          	sw	x8,8(x2)
     744:	00050413          	addi	x8,x10,0
     748:	00042783          	lw	x15,0(x8)
     74c:	00800537          	lui	x10,0x800
     750:	00912223          	sw	x9,4(x2)
     754:	00112623          	sw	x1,12(x2)
     758:	00100493          	addi	x9,x0,1
     75c:	01700813          	addi	x16,x0,23
     760:	01350513          	addi	x10,x10,19 # 800013 <_stack_ptr+0x7f0013>
     764:	02d00893          	addi	x17,x0,45
     768:	02b00313          	addi	x6,x0,43
     76c:	0007c603          	lbu	x12,0(x15)
     770:	ff760593          	addi	x11,x12,-9
     774:	0ff5f693          	andi	x13,x11,255
     778:	00d55733          	srl	x14,x10,x13
     77c:	00177713          	andi	x14,x14,1
     780:	02d86463          	bltu	x16,x13,7a8 <parse_factor+0x6c>
     784:	02070a63          	beq	x14,x0,7b8 <parse_factor+0x7c>
     788:	00178793          	addi	x15,x15,1
     78c:	00f42023          	sw	x15,0(x8)
     790:	0007c603          	lbu	x12,0(x15)
     794:	ff760593          	addi	x11,x12,-9
     798:	0ff5f693          	andi	x13,x11,255
     79c:	00d55733          	srl	x14,x10,x13
     7a0:	00177713          	andi	x14,x14,1
     7a4:	fed870e3          	bgeu	x16,x13,784 <parse_factor+0x48>
     7a8:	00661863          	bne	x12,x6,7b8 <parse_factor+0x7c>
     7ac:	00178793          	addi	x15,x15,1
     7b0:	00f42023          	sw	x15,0(x8)
     7b4:	fb9ff06f          	jal	x0,76c <parse_factor+0x30>
     7b8:	01161a63          	bne	x12,x17,7cc <parse_factor+0x90>
     7bc:	00178793          	addi	x15,x15,1
     7c0:	409004b3          	sub	x9,x0,x9
     7c4:	00f42023          	sw	x15,0(x8)
     7c8:	fa5ff06f          	jal	x0,76c <parse_factor+0x30>
     7cc:	00800537          	lui	x10,0x800
     7d0:	01350513          	addi	x10,x10,19 # 800013 <_stack_ptr+0x7f0013>
     7d4:	0ff5f693          	andi	x13,x11,255
     7d8:	00d55733          	srl	x14,x10,x13
     7dc:	01700813          	addi	x16,x0,23
     7e0:	00177713          	andi	x14,x14,1
     7e4:	02d86463          	bltu	x16,x13,80c <parse_factor+0xd0>
     7e8:	0a070c63          	beq	x14,x0,8a0 <parse_factor+0x164>
     7ec:	00178793          	addi	x15,x15,1
     7f0:	00f42023          	sw	x15,0(x8)
     7f4:	0007c603          	lbu	x12,0(x15)
     7f8:	ff760593          	addi	x11,x12,-9
     7fc:	0ff5f693          	andi	x13,x11,255
     800:	00d55733          	srl	x14,x10,x13
     804:	00177713          	andi	x14,x14,1
     808:	fed870e3          	bgeu	x16,x13,7e8 <parse_factor+0xac>
     80c:	02e00713          	addi	x14,x0,46
     810:	12e60c63          	beq	x12,x14,948 <parse_factor+0x20c>
     814:	02800713          	addi	x14,x0,40
     818:	14e61c63          	bne	x12,x14,970 <parse_factor+0x234>
     81c:	00178793          	addi	x15,x15,1
     820:	00f42023          	sw	x15,0(x8)
     824:	00040513          	addi	x10,x8,0
     828:	00000097          	auipc	x1,0x0
     82c:	2e0080e7          	jalr	x1,736(x1) # b08 <parse_expression>
     830:	00042703          	lw	x14,0(x8)
     834:	00800637          	lui	x12,0x800
     838:	01360613          	addi	x12,x12,19 # 800013 <_stack_ptr+0x7f0013>
     83c:	00074803          	lbu	x16,0(x14)
     840:	01700593          	addi	x11,x0,23
     844:	ff780793          	addi	x15,x16,-9
     848:	0ff7f793          	andi	x15,x15,255
     84c:	00f656b3          	srl	x13,x12,x15
     850:	0016f693          	andi	x13,x13,1
     854:	02f5e463          	bltu	x11,x15,87c <parse_factor+0x140>
     858:	00170713          	addi	x14,x14,1
     85c:	0e068a63          	beq	x13,x0,950 <parse_factor+0x214>
     860:	00e42023          	sw	x14,0(x8)
     864:	00074803          	lbu	x16,0(x14)
     868:	ff780793          	addi	x15,x16,-9
     86c:	0ff7f793          	andi	x15,x15,255
     870:	00f656b3          	srl	x13,x12,x15
     874:	0016f693          	andi	x13,x13,1
     878:	fef5f0e3          	bgeu	x11,x15,858 <parse_factor+0x11c>
     87c:	02900793          	addi	x15,x0,41
     880:	0cf81863          	bne	x16,x15,950 <parse_factor+0x214>
     884:	00170713          	addi	x14,x14,1
     888:	00050593          	addi	x11,x10,0
     88c:	00e42023          	sw	x14,0(x8)
     890:	00048513          	addi	x10,x9,0
     894:	00003097          	auipc	x1,0x3
     898:	d94080e7          	jalr	x1,-620(x1) # 3628 <__mulsi3>
     89c:	0980006f          	jal	x0,934 <parse_factor+0x1f8>
     8a0:	00800737          	lui	x14,0x800
     8a4:	01370713          	addi	x14,x14,19 # 800013 <_stack_ptr+0x7f0013>
     8a8:	0ff5f593          	andi	x11,x11,255
     8ac:	00b75733          	srl	x14,x14,x11
     8b0:	01700693          	addi	x13,x0,23
     8b4:	00177713          	andi	x14,x14,1
     8b8:	02b6e863          	bltu	x13,x11,8e8 <parse_factor+0x1ac>
     8bc:	00178793          	addi	x15,x15,1
     8c0:	08070863          	beq	x14,x0,950 <parse_factor+0x214>
     8c4:	00f42023          	sw	x15,0(x8)
     8c8:	0007c603          	lbu	x12,0(x15)
     8cc:	00800737          	lui	x14,0x800
     8d0:	01370713          	addi	x14,x14,19 # 800013 <_stack_ptr+0x7f0013>
     8d4:	ff760593          	addi	x11,x12,-9
     8d8:	0ff5f593          	andi	x11,x11,255
     8dc:	00b75733          	srl	x14,x14,x11
     8e0:	00177713          	andi	x14,x14,1
     8e4:	fcb6fce3          	bgeu	x13,x11,8bc <parse_factor+0x180>
     8e8:	fd060693          	addi	x13,x12,-48
     8ec:	0ff6f613          	andi	x12,x13,255
     8f0:	00900713          	addi	x14,x0,9
     8f4:	00000593          	addi	x11,x0,0
     8f8:	00900513          	addi	x10,x0,9
     8fc:	04c76a63          	bltu	x14,x12,950 <parse_factor+0x214>
     900:	00178793          	addi	x15,x15,1
     904:	00f42023          	sw	x15,0(x8)
     908:	00259713          	slli	x14,x11,0x2
     90c:	0007c603          	lbu	x12,0(x15)
     910:	00b70733          	add	x14,x14,x11
     914:	00171713          	slli	x14,x14,0x1
     918:	00e685b3          	add	x11,x13,x14
     91c:	fd060693          	addi	x13,x12,-48
     920:	0ff6f713          	andi	x14,x13,255
     924:	fce57ee3          	bgeu	x10,x14,900 <parse_factor+0x1c4>
     928:	00048513          	addi	x10,x9,0
     92c:	00003097          	auipc	x1,0x3
     930:	cfc080e7          	jalr	x1,-772(x1) # 3628 <__mulsi3>
     934:	00c12083          	lw	x1,12(x2)
     938:	00812403          	lw	x8,8(x2)
     93c:	00412483          	lw	x9,4(x2)
     940:	01010113          	addi	x2,x2,16
     944:	00008067          	jalr	x0,0(x1)
     948:	00100793          	addi	x15,x0,1
     94c:	00f40323          	sb	x15,6(x8)
     950:	00100793          	addi	x15,x0,1
     954:	00f40223          	sb	x15,4(x8)
     958:	00c12083          	lw	x1,12(x2)
     95c:	00812403          	lw	x8,8(x2)
     960:	00412483          	lw	x9,4(x2)
     964:	00000513          	addi	x10,x0,0
     968:	01010113          	addi	x2,x2,16
     96c:	00008067          	jalr	x0,0(x1)
     970:	0df67713          	andi	x14,x12,223
     974:	05800693          	addi	x13,x0,88
     978:	f2d714e3          	bne	x14,x13,8a0 <parse_factor+0x164>
     97c:	00006737          	lui	x14,0x6
     980:	aa072583          	lw	x11,-1376(x14) # 5aa0 <g_var_x_int>
     984:	00178793          	addi	x15,x15,1
     988:	00f42023          	sw	x15,0(x8)
     98c:	00048513          	addi	x10,x9,0
     990:	00003097          	auipc	x1,0x3
     994:	c98080e7          	jalr	x1,-872(x1) # 3628 <__mulsi3>
     998:	00c12083          	lw	x1,12(x2)
     99c:	00812403          	lw	x8,8(x2)
     9a0:	00412483          	lw	x9,4(x2)
     9a4:	01010113          	addi	x2,x2,16
     9a8:	00008067          	jalr	x0,0(x1)

000009ac <parse_term>:
     9ac:	fe010113          	addi	x2,x2,-32
     9b0:	00812c23          	sw	x8,24(x2)
     9b4:	01512223          	sw	x21,4(x2)
     9b8:	00112e23          	sw	x1,28(x2)
     9bc:	00050a93          	addi	x21,x10,0
     9c0:	00000097          	auipc	x1,0x0
     9c4:	d7c080e7          	jalr	x1,-644(x1) # 73c <parse_factor>
     9c8:	004ac783          	lbu	x15,4(x21)
     9cc:	00050413          	addi	x8,x10,0
     9d0:	0a079c63          	bne	x15,x0,a88 <parse_term+0xdc>
     9d4:	00912a23          	sw	x9,20(x2)
     9d8:	008004b7          	lui	x9,0x800
     9dc:	01212823          	sw	x18,16(x2)
     9e0:	01312623          	sw	x19,12(x2)
     9e4:	01412423          	sw	x20,8(x2)
     9e8:	01700913          	addi	x18,x0,23
     9ec:	01348493          	addi	x9,x9,19 # 800013 <_stack_ptr+0x7f0013>
     9f0:	02a00993          	addi	x19,x0,42
     9f4:	02f00a13          	addi	x20,x0,47
     9f8:	000aa703          	lw	x14,0(x21)
     9fc:	00074603          	lbu	x12,0(x14)
     a00:	ff760793          	addi	x15,x12,-9
     a04:	0ff7f793          	andi	x15,x15,255
     a08:	00f4d6b3          	srl	x13,x9,x15
     a0c:	0016f693          	andi	x13,x13,1
     a10:	02f96463          	bltu	x18,x15,a38 <parse_term+0x8c>
     a14:	00170713          	addi	x14,x14,1
     a18:	06068063          	beq	x13,x0,a78 <parse_term+0xcc>
     a1c:	00eaa023          	sw	x14,0(x21)
     a20:	00074603          	lbu	x12,0(x14)
     a24:	ff760793          	addi	x15,x12,-9
     a28:	0ff7f793          	andi	x15,x15,255
     a2c:	00f4d6b3          	srl	x13,x9,x15
     a30:	0016f693          	andi	x13,x13,1
     a34:	fef970e3          	bgeu	x18,x15,a14 <parse_term+0x68>
     a38:	07360463          	beq	x12,x19,aa0 <parse_term+0xf4>
     a3c:	03461e63          	bne	x12,x20,a78 <parse_term+0xcc>
     a40:	00170713          	addi	x14,x14,1
     a44:	00eaa023          	sw	x14,0(x21)
     a48:	000a8513          	addi	x10,x21,0
     a4c:	00000097          	auipc	x1,0x0
     a50:	cf0080e7          	jalr	x1,-784(x1) # 73c <parse_factor>
     a54:	004ac783          	lbu	x15,4(x21)
     a58:	00050593          	addi	x11,x10,0
     a5c:	08079063          	bne	x15,x0,adc <parse_term+0x130>
     a60:	06058a63          	beq	x11,x0,ad4 <parse_term+0x128>
     a64:	00040513          	addi	x10,x8,0
     a68:	00003097          	auipc	x1,0x3
     a6c:	c78080e7          	jalr	x1,-904(x1) # 36e0 <__divsi3>
     a70:	00050413          	addi	x8,x10,0
     a74:	f85ff06f          	jal	x0,9f8 <parse_term+0x4c>
     a78:	01412483          	lw	x9,20(x2)
     a7c:	01012903          	lw	x18,16(x2)
     a80:	00c12983          	lw	x19,12(x2)
     a84:	00812a03          	lw	x20,8(x2)
     a88:	01c12083          	lw	x1,28(x2)
     a8c:	00040513          	addi	x10,x8,0
     a90:	01812403          	lw	x8,24(x2)
     a94:	00412a83          	lw	x21,4(x2)
     a98:	02010113          	addi	x2,x2,32
     a9c:	00008067          	jalr	x0,0(x1)
     aa0:	00170713          	addi	x14,x14,1
     aa4:	00eaa023          	sw	x14,0(x21)
     aa8:	000a8513          	addi	x10,x21,0
     aac:	00000097          	auipc	x1,0x0
     ab0:	c90080e7          	jalr	x1,-880(x1) # 73c <parse_factor>
     ab4:	004ac783          	lbu	x15,4(x21)
     ab8:	00050593          	addi	x11,x10,0
     abc:	02079063          	bne	x15,x0,adc <parse_term+0x130>
     ac0:	00040513          	addi	x10,x8,0
     ac4:	00003097          	auipc	x1,0x3
     ac8:	b64080e7          	jalr	x1,-1180(x1) # 3628 <__mulsi3>
     acc:	00050413          	addi	x8,x10,0
     ad0:	f29ff06f          	jal	x0,9f8 <parse_term+0x4c>
     ad4:	10100793          	addi	x15,x0,257
     ad8:	00fa9223          	sh	x15,4(x21)
     adc:	00000413          	addi	x8,x0,0
     ae0:	01c12083          	lw	x1,28(x2)
     ae4:	00040513          	addi	x10,x8,0
     ae8:	01812403          	lw	x8,24(x2)
     aec:	01412483          	lw	x9,20(x2)
     af0:	01012903          	lw	x18,16(x2)
     af4:	00c12983          	lw	x19,12(x2)
     af8:	00812a03          	lw	x20,8(x2)
     afc:	00412a83          	lw	x21,4(x2)
     b00:	02010113          	addi	x2,x2,32
     b04:	00008067          	jalr	x0,0(x1)

00000b08 <parse_expression>:
     b08:	fe010113          	addi	x2,x2,-32
     b0c:	00812c23          	sw	x8,24(x2)
     b10:	01312623          	sw	x19,12(x2)
     b14:	00050413          	addi	x8,x10,0
     b18:	00112e23          	sw	x1,28(x2)
     b1c:	00000097          	auipc	x1,0x0
     b20:	e90080e7          	jalr	x1,-368(x1) # 9ac <parse_term>
     b24:	00444783          	lbu	x15,4(x8)
     b28:	00050993          	addi	x19,x10,0
     b2c:	0a079263          	bne	x15,x0,bd0 <parse_expression+0xc8>
     b30:	01412423          	sw	x20,8(x2)
     b34:	00800a37          	lui	x20,0x800
     b38:	00912a23          	sw	x9,20(x2)
     b3c:	01212823          	sw	x18,16(x2)
     b40:	01512223          	sw	x21,4(x2)
     b44:	013a0a13          	addi	x20,x20,19 # 800013 <_stack_ptr+0x7f0013>
     b48:	01700a93          	addi	x21,x0,23
     b4c:	02b00493          	addi	x9,x0,43
     b50:	02d00913          	addi	x18,x0,45
     b54:	00042703          	lw	x14,0(x8)
     b58:	00074603          	lbu	x12,0(x14)
     b5c:	ff760793          	addi	x15,x12,-9
     b60:	0ff7f793          	andi	x15,x15,255
     b64:	00fa56b3          	srl	x13,x20,x15
     b68:	0016f693          	andi	x13,x13,1
     b6c:	02fae463          	bltu	x21,x15,b94 <parse_expression+0x8c>
     b70:	00170713          	addi	x14,x14,1
     b74:	04068663          	beq	x13,x0,bc0 <parse_expression+0xb8>
     b78:	00e42023          	sw	x14,0(x8)
     b7c:	00074603          	lbu	x12,0(x14)
     b80:	ff760793          	addi	x15,x12,-9
     b84:	0ff7f793          	andi	x15,x15,255
     b88:	00fa56b3          	srl	x13,x20,x15
     b8c:	0016f693          	andi	x13,x13,1
     b90:	fefaf0e3          	bgeu	x21,x15,b70 <parse_expression+0x68>
     b94:	04960a63          	beq	x12,x9,be8 <parse_expression+0xe0>
     b98:	03261463          	bne	x12,x18,bc0 <parse_expression+0xb8>
     b9c:	00170713          	addi	x14,x14,1
     ba0:	00e42023          	sw	x14,0(x8)
     ba4:	00040513          	addi	x10,x8,0
     ba8:	00000097          	auipc	x1,0x0
     bac:	e04080e7          	jalr	x1,-508(x1) # 9ac <parse_term>
     bb0:	00444783          	lbu	x15,4(x8)
     bb4:	04079c63          	bne	x15,x0,c0c <parse_expression+0x104>
     bb8:	40a989b3          	sub	x19,x19,x10
     bbc:	f99ff06f          	jal	x0,b54 <parse_expression+0x4c>
     bc0:	01412483          	lw	x9,20(x2)
     bc4:	01012903          	lw	x18,16(x2)
     bc8:	00812a03          	lw	x20,8(x2)
     bcc:	00412a83          	lw	x21,4(x2)
     bd0:	01c12083          	lw	x1,28(x2)
     bd4:	01812403          	lw	x8,24(x2)
     bd8:	00098513          	addi	x10,x19,0
     bdc:	00c12983          	lw	x19,12(x2)
     be0:	02010113          	addi	x2,x2,32
     be4:	00008067          	jalr	x0,0(x1)
     be8:	00170713          	addi	x14,x14,1
     bec:	00e42023          	sw	x14,0(x8)
     bf0:	00040513          	addi	x10,x8,0
     bf4:	00000097          	auipc	x1,0x0
     bf8:	db8080e7          	jalr	x1,-584(x1) # 9ac <parse_term>
     bfc:	00444783          	lbu	x15,4(x8)
     c00:	00079663          	bne	x15,x0,c0c <parse_expression+0x104>
     c04:	00a989b3          	add	x19,x19,x10
     c08:	f4dff06f          	jal	x0,b54 <parse_expression+0x4c>
     c0c:	01c12083          	lw	x1,28(x2)
     c10:	01812403          	lw	x8,24(x2)
     c14:	00000993          	addi	x19,x0,0
     c18:	01412483          	lw	x9,20(x2)
     c1c:	01012903          	lw	x18,16(x2)
     c20:	00812a03          	lw	x20,8(x2)
     c24:	00412a83          	lw	x21,4(x2)
     c28:	00098513          	addi	x10,x19,0
     c2c:	00c12983          	lw	x19,12(x2)
     c30:	02010113          	addi	x2,x2,32
     c34:	00008067          	jalr	x0,0(x1)

00000c38 <eval_expression>:
     c38:	fe010113          	addi	x2,x2,-32
     c3c:	00050793          	addi	x15,x10,0
     c40:	00810513          	addi	x10,x2,8
     c44:	00812c23          	sw	x8,24(x2)
     c48:	00f12423          	sw	x15,8(x2)
     c4c:	00058413          	addi	x8,x11,0
     c50:	00112e23          	sw	x1,28(x2)
     c54:	00011623          	sh	x0,12(x2)
     c58:	00010723          	sb	x0,14(x2)
     c5c:	00000097          	auipc	x1,0x0
     c60:	eac080e7          	jalr	x1,-340(x1) # b08 <parse_expression>
     c64:	00812703          	lw	x14,8(x2)
     c68:	00800837          	lui	x16,0x800
     c6c:	01380813          	addi	x16,x16,19 # 800013 <_stack_ptr+0x7f0013>
     c70:	00074603          	lbu	x12,0(x14)
     c74:	01700593          	addi	x11,x0,23
     c78:	00170713          	addi	x14,x14,1
     c7c:	ff760793          	addi	x15,x12,-9
     c80:	0ff7f793          	andi	x15,x15,255
     c84:	00f856b3          	srl	x13,x16,x15
     c88:	0016f693          	andi	x13,x13,1
     c8c:	02f5e463          	bltu	x11,x15,cb4 <eval_expression+0x7c>
     c90:	04068463          	beq	x13,x0,cd8 <eval_expression+0xa0>
     c94:	00e12423          	sw	x14,8(x2)
     c98:	00074603          	lbu	x12,0(x14)
     c9c:	00170713          	addi	x14,x14,1
     ca0:	ff760793          	addi	x15,x12,-9
     ca4:	0ff7f793          	andi	x15,x15,255
     ca8:	00f856b3          	srl	x13,x16,x15
     cac:	0016f693          	andi	x13,x13,1
     cb0:	fef5f0e3          	bgeu	x11,x15,c90 <eval_expression+0x58>
     cb4:	00c14783          	lbu	x15,12(x2)
     cb8:	00f66633          	or	x12,x12,x15
     cbc:	00061e63          	bne	x12,x0,cd8 <eval_expression+0xa0>
     cc0:	00a42023          	sw	x10,0(x8)
     cc4:	01c12083          	lw	x1,28(x2)
     cc8:	01812403          	lw	x8,24(x2)
     ccc:	00100513          	addi	x10,x0,1
     cd0:	02010113          	addi	x2,x2,32
     cd4:	00008067          	jalr	x0,0(x1)
     cd8:	00d14783          	lbu	x15,13(x2)
     cdc:	04078263          	beq	x15,x0,d20 <eval_expression+0xe8>
     ce0:	000057b7          	lui	x15,0x5
     ce4:	00003737          	lui	x14,0x3
     ce8:	04400693          	addi	x13,x0,68
     cec:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
     cf0:	79470713          	addi	x14,x14,1940 # 3794 <__modsi3+0x30>
     cf4:	00170713          	addi	x14,x14,1
     cf8:	00d78023          	sb	x13,0(x15)
     cfc:	00074683          	lbu	x13,0(x14)
     d00:	00178793          	addi	x15,x15,1
     d04:	fe0698e3          	bne	x13,x0,cf4 <eval_expression+0xbc>
     d08:	00078023          	sb	x0,0(x15)
     d0c:	00000513          	addi	x10,x0,0
     d10:	01c12083          	lw	x1,28(x2)
     d14:	01812403          	lw	x8,24(x2)
     d18:	02010113          	addi	x2,x2,32
     d1c:	00008067          	jalr	x0,0(x1)
     d20:	00e14783          	lbu	x15,14(x2)
     d24:	04500693          	addi	x13,x0,69
     d28:	02078a63          	beq	x15,x0,d5c <eval_expression+0x124>
     d2c:	000057b7          	lui	x15,0x5
     d30:	00003737          	lui	x14,0x3
     d34:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
     d38:	79c70713          	addi	x14,x14,1948 # 379c <__modsi3+0x38>
     d3c:	00170713          	addi	x14,x14,1
     d40:	00d78023          	sb	x13,0(x15)
     d44:	00074683          	lbu	x13,0(x14)
     d48:	00178793          	addi	x15,x15,1
     d4c:	fe0698e3          	bne	x13,x0,d3c <eval_expression+0x104>
     d50:	00078023          	sb	x0,0(x15)
     d54:	00000513          	addi	x10,x0,0
     d58:	fb9ff06f          	jal	x0,d10 <eval_expression+0xd8>
     d5c:	000057b7          	lui	x15,0x5
     d60:	00003737          	lui	x14,0x3
     d64:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
     d68:	79c70713          	addi	x14,x14,1948 # 379c <__modsi3+0x38>
     d6c:	00170713          	addi	x14,x14,1
     d70:	00d78023          	sb	x13,0(x15)
     d74:	00074683          	lbu	x13,0(x14)
     d78:	00178793          	addi	x15,x15,1
     d7c:	fe0698e3          	bne	x13,x0,d6c <eval_expression+0x134>
     d80:	00078023          	sb	x0,0(x15)
     d84:	00000513          	addi	x10,x0,0
     d88:	f89ff06f          	jal	x0,d10 <eval_expression+0xd8>

00000d8c <lcd_clear>:
     d8c:	00001737          	lui	x14,0x1
     d90:	100046b7          	lui	x13,0x10004
     d94:	80170713          	addi	x14,x14,-2047 # 801 <parse_factor+0xc5>
     d98:	000017b7          	lui	x15,0x1
     d9c:	00e6a023          	sw	x14,0(x13) # 10004000 <_stack_ptr+0xfff4000>
     da0:	c0178793          	addi	x15,x15,-1023 # c01 <parse_expression+0xf9>
     da4:	00f6a023          	sw	x15,0(x13)
     da8:	ff010113          	addi	x2,x2,-16
     dac:	00a00793          	addi	x15,x0,10
     db0:	00f12423          	sw	x15,8(x2)
     db4:	00812783          	lw	x15,8(x2)
     db8:	00f05c63          	bge	x0,x15,dd0 <lcd_clear+0x44>
     dbc:	00812783          	lw	x15,8(x2)
     dc0:	fff78793          	addi	x15,x15,-1
     dc4:	00f12423          	sw	x15,8(x2)
     dc8:	00812783          	lw	x15,8(x2)
     dcc:	fef048e3          	blt	x0,x15,dbc <lcd_clear+0x30>
     dd0:	000017b7          	lui	x15,0x1
     dd4:	80178793          	addi	x15,x15,-2047 # 801 <parse_factor+0xc5>
     dd8:	10004737          	lui	x14,0x10004
     ddc:	00f72023          	sw	x15,0(x14) # 10004000 <_stack_ptr+0xfff4000>
     de0:	16800793          	addi	x15,x0,360
     de4:	00f12623          	sw	x15,12(x2)
     de8:	00c12783          	lw	x15,12(x2)
     dec:	00f05c63          	bge	x0,x15,e04 <lcd_clear+0x78>
     df0:	00c12783          	lw	x15,12(x2)
     df4:	fff78793          	addi	x15,x15,-1
     df8:	00f12623          	sw	x15,12(x2)
     dfc:	00c12783          	lw	x15,12(x2)
     e00:	fef048e3          	blt	x0,x15,df0 <lcd_clear+0x64>
     e04:	000027b7          	lui	x15,0x2
     e08:	71078793          	addi	x15,x15,1808 # 2710 <__moddi3+0x1b4>
     e0c:	00f12223          	sw	x15,4(x2)
     e10:	00412783          	lw	x15,4(x2)
     e14:	00f05c63          	bge	x0,x15,e2c <lcd_clear+0xa0>
     e18:	00412783          	lw	x15,4(x2)
     e1c:	fff78793          	addi	x15,x15,-1
     e20:	00f12223          	sw	x15,4(x2)
     e24:	00412783          	lw	x15,4(x2)
     e28:	fef048e3          	blt	x0,x15,e18 <lcd_clear+0x8c>
     e2c:	01010113          	addi	x2,x2,16
     e30:	00008067          	jalr	x0,0(x1)

00000e34 <f_parse_unary>:
     e34:	fc010113          	addi	x2,x2,-64
     e38:	00052783          	lw	x15,0(x10)
     e3c:	02812c23          	sw	x8,56(x2)
     e40:	00050413          	addi	x8,x10,0
     e44:	00800537          	lui	x10,0x800
     e48:	02112e23          	sw	x1,60(x2)
     e4c:	01700813          	addi	x16,x0,23
     e50:	01350513          	addi	x10,x10,19 # 800013 <_stack_ptr+0x7f0013>
     e54:	02b00893          	addi	x17,x0,43
     e58:	0100006f          	jal	x0,e68 <f_parse_unary+0x34>
     e5c:	02070463          	beq	x14,x0,e84 <f_parse_unary+0x50>
     e60:	00178793          	addi	x15,x15,1
     e64:	00f42023          	sw	x15,0(x8)
     e68:	0007c683          	lbu	x13,0(x15)
     e6c:	ff768593          	addi	x11,x13,-9
     e70:	0ff5f613          	andi	x12,x11,255
     e74:	00c55733          	srl	x14,x10,x12
     e78:	00177713          	andi	x14,x14,1
     e7c:	fec870e3          	bgeu	x16,x12,e5c <f_parse_unary+0x28>
     e80:	ff1680e3          	beq	x13,x17,e60 <f_parse_unary+0x2c>
     e84:	00800637          	lui	x12,0x800
     e88:	02d00713          	addi	x14,x0,45
     e8c:	01700513          	addi	x10,x0,23
     e90:	01360613          	addi	x12,x12,19 # 800013 <_stack_ptr+0x7f0013>
     e94:	1ce68863          	beq	x13,x14,1064 <f_parse_unary+0x230>
     e98:	0ff5f593          	andi	x11,x11,255
     e9c:	00b65733          	srl	x14,x12,x11
     ea0:	00177713          	andi	x14,x14,1
     ea4:	02b56463          	bltu	x10,x11,ecc <f_parse_unary+0x98>
     ea8:	00178793          	addi	x15,x15,1
     eac:	12070663          	beq	x14,x0,fd8 <f_parse_unary+0x1a4>
     eb0:	00f42023          	sw	x15,0(x8)
     eb4:	0007c683          	lbu	x13,0(x15)
     eb8:	ff768593          	addi	x11,x13,-9
     ebc:	0ff5f593          	andi	x11,x11,255
     ec0:	00b65733          	srl	x14,x12,x11
     ec4:	00177713          	andi	x14,x14,1
     ec8:	feb570e3          	bgeu	x10,x11,ea8 <f_parse_unary+0x74>
     ecc:	02800713          	addi	x14,x0,40
     ed0:	26e68e63          	beq	x13,x14,114c <f_parse_unary+0x318>
     ed4:	fd068713          	addi	x14,x13,-48
     ed8:	0ff77713          	andi	x14,x14,255
     edc:	00900613          	addi	x12,x0,9
     ee0:	10e67463          	bgeu	x12,x14,fe8 <f_parse_unary+0x1b4>
     ee4:	02e00713          	addi	x14,x0,46
     ee8:	78e68663          	beq	x13,x14,1674 <f_parse_unary+0x840>
     eec:	fdf6f713          	andi	x14,x13,-33
     ef0:	fbf70713          	addi	x14,x14,-65
     ef4:	0ff77713          	andi	x14,x14,255
     ef8:	01900613          	addi	x12,x0,25
     efc:	00000593          	addi	x11,x0,0
     f00:	0ce66c63          	bltu	x12,x14,fd8 <f_parse_unary+0x1a4>
     f04:	02912a23          	sw	x9,52(x2)
     f08:	01900513          	addi	x10,x0,25
     f0c:	00f00813          	addi	x16,x0,15
     f10:	00900313          	addi	x6,x0,9
     f14:	05f00e13          	addi	x28,x0,95
     f18:	f9f68713          	addi	x14,x13,-97
     f1c:	fbf68613          	addi	x12,x13,-65
     f20:	0ff77713          	andi	x14,x14,255
     f24:	0ff67613          	andi	x12,x12,255
     f28:	1ee57a63          	bgeu	x10,x14,111c <f_parse_unary+0x2e8>
     f2c:	fd068713          	addi	x14,x13,-48
     f30:	0ff77713          	andi	x14,x14,255
     f34:	02068893          	addi	x17,x13,32
     f38:	20c57463          	bgeu	x10,x12,1140 <f_parse_unary+0x30c>
     f3c:	1ee37063          	bgeu	x6,x14,111c <f_parse_unary+0x2e8>
     f40:	29c68463          	beq	x13,x28,11c8 <f_parse_unary+0x394>
     f44:	02058713          	addi	x14,x11,32
     f48:	002705b3          	add	x11,x14,x2
     f4c:	00800537          	lui	x10,0x800
     f50:	ff768713          	addi	x14,x13,-9
     f54:	01350513          	addi	x10,x10,19 # 800013 <_stack_ptr+0x7f0013>
     f58:	0ff77713          	andi	x14,x14,255
     f5c:	fe058823          	sb	x0,-16(x11)
     f60:	00e55633          	srl	x12,x10,x14
     f64:	01700593          	addi	x11,x0,23
     f68:	00167613          	andi	x12,x12,1
     f6c:	02e5e463          	bltu	x11,x14,f94 <f_parse_unary+0x160>
     f70:	00178793          	addi	x15,x15,1
     f74:	24060663          	beq	x12,x0,11c0 <f_parse_unary+0x38c>
     f78:	00f42023          	sw	x15,0(x8)
     f7c:	0007c683          	lbu	x13,0(x15)
     f80:	ff768713          	addi	x14,x13,-9
     f84:	0ff77713          	andi	x14,x14,255
     f88:	00e55633          	srl	x12,x10,x14
     f8c:	00167613          	andi	x12,x12,1
     f90:	fee5f0e3          	bgeu	x11,x14,f70 <f_parse_unary+0x13c>
     f94:	02800713          	addi	x14,x0,40
     f98:	01014483          	lbu	x9,16(x2)
     f9c:	22e68e63          	beq	x13,x14,11d8 <f_parse_unary+0x3a4>
     fa0:	07000793          	addi	x15,x0,112
     fa4:	02f48263          	beq	x9,x15,fc8 <f_parse_unary+0x194>
     fa8:	06500793          	addi	x15,x0,101
     fac:	02f49463          	bne	x9,x15,fd4 <f_parse_unary+0x1a0>
     fb0:	01114783          	lbu	x15,17(x2)
     fb4:	02079063          	bne	x15,x0,fd4 <f_parse_unary+0x1a0>
     fb8:	000047b7          	lui	x15,0x4
     fbc:	ce87a507          	flw	f10,-792(x15) # 3ce8 <__clz_tab+0x168>
     fc0:	03412483          	lw	x9,52(x2)
     fc4:	0b80006f          	jal	x0,107c <f_parse_unary+0x248>
     fc8:	01114703          	lbu	x14,17(x2)
     fcc:	06900793          	addi	x15,x0,105
     fd0:	2af70863          	beq	x14,x15,1280 <f_parse_unary+0x44c>
     fd4:	03412483          	lw	x9,52(x2)
     fd8:	00100793          	addi	x15,x0,1
     fdc:	f0000553          	fmv.w.x	f10,x0
     fe0:	00f40223          	sb	x15,4(x8)
     fe4:	0980006f          	jal	x0,107c <f_parse_unary+0x248>
     fe8:	000046b7          	lui	x13,0x4
     fec:	f0000553          	fmv.w.x	f10,x0
     ff0:	cec6a687          	flw	f13,-788(x13) # 3cec <__clz_tab+0x16c>
     ff4:	00004537          	lui	x10,0x4
     ff8:	000046b7          	lui	x13,0x4
     ffc:	ce46a707          	flw	f14,-796(x13) # 3ce4 <__clz_tab+0x164>
    1000:	00900613          	addi	x12,x0,9
    1004:	00178693          	addi	x13,x15,1
    1008:	b4450513          	addi	x10,x10,-1212 # 3b44 <CSWTCH.180>
    100c:	00271793          	slli	x15,x14,0x2
    1010:	10d57553          	fmul.s	f10,f10,f13
    1014:	20e707d3          	fsgnj.s	f15,f14,f14
    1018:	00f507b3          	add	x15,x10,x15
    101c:	00c70463          	beq	x14,x12,1024 <f_parse_unary+0x1f0>
    1020:	0007a787          	flw	f15,0(x15)
    1024:	00d42023          	sw	x13,0(x8)
    1028:	0006c583          	lbu	x11,0(x13)
    102c:	00068793          	addi	x15,x13,0
    1030:	00f57553          	fadd.s	f10,f10,f15
    1034:	fd058713          	addi	x14,x11,-48
    1038:	0ff77713          	andi	x14,x14,255
    103c:	00168693          	addi	x13,x13,1
    1040:	fce676e3          	bgeu	x12,x14,100c <f_parse_unary+0x1d8>
    1044:	02e00713          	addi	x14,x0,46
    1048:	04e58263          	beq	x11,x14,108c <f_parse_unary+0x258>
    104c:	03c12083          	lw	x1,60(x2)
    1050:	03812403          	lw	x8,56(x2)
    1054:	f00007d3          	fmv.w.x	f15,x0
    1058:	00f57553          	fadd.s	f10,f10,f15
    105c:	04010113          	addi	x2,x2,64
    1060:	00008067          	jalr	x0,0(x1)
    1064:	00178793          	addi	x15,x15,1
    1068:	00f42023          	sw	x15,0(x8)
    106c:	00040513          	addi	x10,x8,0
    1070:	00000097          	auipc	x1,0x0
    1074:	dc4080e7          	jalr	x1,-572(x1) # e34 <f_parse_unary>
    1078:	20a51553          	fsgnjn.s	f10,f10,f10
    107c:	03c12083          	lw	x1,60(x2)
    1080:	03812403          	lw	x8,56(x2)
    1084:	04010113          	addi	x2,x2,64
    1088:	00008067          	jalr	x0,0(x1)
    108c:	00178713          	addi	x14,x15,1
    1090:	00e42023          	sw	x14,0(x8)
    1094:	0017c703          	lbu	x14,1(x15)
    1098:	fd070713          	addi	x14,x14,-48
    109c:	0ff77713          	andi	x14,x14,255
    10a0:	fae666e3          	bltu	x12,x14,104c <f_parse_unary+0x218>
    10a4:	f0000753          	fmv.w.x	f14,x0
    10a8:	000046b7          	lui	x13,0x4
    10ac:	000045b7          	lui	x11,0x4
    10b0:	ce46a607          	flw	f12,-796(x13) # 3ce4 <__clz_tab+0x164>
    10b4:	00278793          	addi	x15,x15,2
    10b8:	00000693          	addi	x13,x0,0
    10bc:	00500893          	addi	x17,x0,5
    10c0:	00900513          	addi	x10,x0,9
    10c4:	b4458593          	addi	x11,x11,-1212 # 3b44 <CSWTCH.180>
    10c8:	00269613          	slli	x12,x13,0x2
    10cc:	00c58633          	add	x12,x11,x12
    10d0:	00168813          	addi	x16,x13,1
    10d4:	02d8e463          	bltu	x17,x13,10fc <f_parse_unary+0x2c8>
    10d8:	00271693          	slli	x13,x14,0x2
    10dc:	20c607d3          	fsgnj.s	f15,f12,f12
    10e0:	00d586b3          	add	x13,x11,x13
    10e4:	00a70463          	beq	x14,x10,10ec <f_parse_unary+0x2b8>
    10e8:	0006a787          	flw	f15,0(x13)
    10ec:	02462687          	flw	f13,36(x12)
    10f0:	0ff87693          	andi	x13,x16,255
    10f4:	10d7f7d3          	fmul.s	f15,f15,f13
    10f8:	00f77753          	fadd.s	f14,f14,f15
    10fc:	00f42023          	sw	x15,0(x8)
    1100:	0007c703          	lbu	x14,0(x15)
    1104:	00178793          	addi	x15,x15,1
    1108:	fd070713          	addi	x14,x14,-48
    110c:	0ff77713          	andi	x14,x14,255
    1110:	fae57ce3          	bgeu	x10,x14,10c8 <f_parse_unary+0x294>
    1114:	00a77553          	fadd.s	f10,f14,f10
    1118:	f65ff06f          	jal	x0,107c <f_parse_unary+0x248>
    111c:	0b058a63          	beq	x11,x16,11d0 <f_parse_unary+0x39c>
    1120:	00178793          	addi	x15,x15,1
    1124:	02058713          	addi	x14,x11,32
    1128:	00270733          	add	x14,x14,x2
    112c:	00f42023          	sw	x15,0(x8)
    1130:	fed70823          	sb	x13,-16(x14)
    1134:	00158593          	addi	x11,x11,1
    1138:	0007c683          	lbu	x13,0(x15)
    113c:	dddff06f          	jal	x0,f18 <f_parse_unary+0xe4>
    1140:	09058863          	beq	x11,x16,11d0 <f_parse_unary+0x39c>
    1144:	0ff8f693          	andi	x13,x17,255
    1148:	fd9ff06f          	jal	x0,1120 <f_parse_unary+0x2ec>
    114c:	00178793          	addi	x15,x15,1
    1150:	00f42023          	sw	x15,0(x8)
    1154:	00040513          	addi	x10,x8,0
    1158:	00001097          	auipc	x1,0x1
    115c:	bd8080e7          	jalr	x1,-1064(x1) # 1d30 <f_parse_expression>
    1160:	00042703          	lw	x14,0(x8)
    1164:	00800637          	lui	x12,0x800
    1168:	01360613          	addi	x12,x12,19 # 800013 <_stack_ptr+0x7f0013>
    116c:	00074583          	lbu	x11,0(x14)
    1170:	01700513          	addi	x10,x0,23
    1174:	ff758793          	addi	x15,x11,-9
    1178:	0ff7f793          	andi	x15,x15,255
    117c:	00f656b3          	srl	x13,x12,x15
    1180:	0016f693          	andi	x13,x13,1
    1184:	02f56463          	bltu	x10,x15,11ac <f_parse_unary+0x378>
    1188:	00170713          	addi	x14,x14,1
    118c:	e40686e3          	beq	x13,x0,fd8 <f_parse_unary+0x1a4>
    1190:	00e42023          	sw	x14,0(x8)
    1194:	00074583          	lbu	x11,0(x14)
    1198:	ff758793          	addi	x15,x11,-9
    119c:	0ff7f793          	andi	x15,x15,255
    11a0:	00f656b3          	srl	x13,x12,x15
    11a4:	0016f693          	andi	x13,x13,1
    11a8:	fef570e3          	bgeu	x10,x15,1188 <f_parse_unary+0x354>
    11ac:	02900793          	addi	x15,x0,41
    11b0:	e2f594e3          	bne	x11,x15,fd8 <f_parse_unary+0x1a4>
    11b4:	00170713          	addi	x14,x14,1
    11b8:	00e42023          	sw	x14,0(x8)
    11bc:	ec1ff06f          	jal	x0,107c <f_parse_unary+0x248>
    11c0:	01014483          	lbu	x9,16(x2)
    11c4:	dddff06f          	jal	x0,fa0 <f_parse_unary+0x16c>
    11c8:	00f00713          	addi	x14,x0,15
    11cc:	f4e59ae3          	bne	x11,x14,1120 <f_parse_unary+0x2ec>
    11d0:	00f00593          	addi	x11,x0,15
    11d4:	d71ff06f          	jal	x0,f44 <f_parse_unary+0x110>
    11d8:	03212823          	sw	x18,48(x2)
    11dc:	02812627          	fsw	f8,44(x2)
    11e0:	00178793          	addi	x15,x15,1
    11e4:	00f42023          	sw	x15,0(x8)
    11e8:	00040513          	addi	x10,x8,0
    11ec:	00001097          	auipc	x1,0x1
    11f0:	b44080e7          	jalr	x1,-1212(x1) # 1d30 <f_parse_expression>
    11f4:	00042903          	lw	x18,0(x8)
    11f8:	008006b7          	lui	x13,0x800
    11fc:	01368693          	addi	x13,x13,19 # 800013 <_stack_ptr+0x7f0013>
    1200:	00094583          	lbu	x11,0(x18)
    1204:	01700613          	addi	x12,x0,23
    1208:	20a50453          	fsgnj.s	f8,f10,f10
    120c:	ff758793          	addi	x15,x11,-9
    1210:	0ff7f793          	andi	x15,x15,255
    1214:	00f6d733          	srl	x14,x13,x15
    1218:	00177713          	andi	x14,x14,1
    121c:	02f66463          	bltu	x12,x15,1244 <f_parse_unary+0x410>
    1220:	02070263          	beq	x14,x0,1244 <f_parse_unary+0x410>
    1224:	00190913          	addi	x18,x18,1
    1228:	01242023          	sw	x18,0(x8)
    122c:	00094583          	lbu	x11,0(x18)
    1230:	ff758793          	addi	x15,x11,-9
    1234:	0ff7f793          	andi	x15,x15,255
    1238:	00f6d733          	srl	x14,x13,x15
    123c:	00177713          	andi	x14,x14,1
    1240:	fef670e3          	bgeu	x12,x15,1220 <f_parse_unary+0x3ec>
    1244:	07300793          	addi	x15,x0,115
    1248:	04f48863          	beq	x9,x15,1298 <f_parse_unary+0x464>
    124c:	06300713          	addi	x14,x0,99
    1250:	1ce48663          	beq	x9,x14,141c <f_parse_unary+0x5e8>
    1254:	07400613          	addi	x12,x0,116
    1258:	20c49863          	bne	x9,x12,1468 <f_parse_unary+0x634>
    125c:	01114703          	lbu	x14,17(x2)
    1260:	06100793          	addi	x15,x0,97
    1264:	50f70463          	beq	x14,x15,176c <f_parse_unary+0x938>
    1268:	02c00793          	addi	x15,x0,44
    126c:	08f58263          	beq	x11,x15,12f0 <f_parse_unary+0x4bc>
    1270:	03412483          	lw	x9,52(x2)
    1274:	03012903          	lw	x18,48(x2)
    1278:	02c12407          	flw	f8,44(x2)
    127c:	d5dff06f          	jal	x0,fd8 <f_parse_unary+0x1a4>
    1280:	01214783          	lbu	x15,18(x2)
    1284:	d40798e3          	bne	x15,x0,fd4 <f_parse_unary+0x1a0>
    1288:	000047b7          	lui	x15,0x4
    128c:	c807a507          	flw	f10,-896(x15) # 3c80 <__clz_tab+0x100>
    1290:	03412483          	lw	x9,52(x2)
    1294:	de9ff06f          	jal	x0,107c <f_parse_unary+0x248>
    1298:	01114783          	lbu	x15,17(x2)
    129c:	07100713          	addi	x14,x0,113
    12a0:	46e78e63          	beq	x15,x14,171c <f_parse_unary+0x8e8>
    12a4:	06900713          	addi	x14,x0,105
    12a8:	fce790e3          	bne	x15,x14,1268 <f_parse_unary+0x434>
    12ac:	01214703          	lbu	x14,18(x2)
    12b0:	06e00793          	addi	x15,x0,110
    12b4:	faf71ae3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    12b8:	01314783          	lbu	x15,19(x2)
    12bc:	6a079263          	bne	x15,x0,1960 <f_parse_unary+0xb2c>
    12c0:	02900793          	addi	x15,x0,41
    12c4:	faf596e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    12c8:	20840553          	fsgnj.s	f10,f8,f8
    12cc:	00190913          	addi	x18,x18,1
    12d0:	01242023          	sw	x18,0(x8)
    12d4:	fffff097          	auipc	x1,0xfffff
    12d8:	de4080e7          	jalr	x1,-540(x1) # b8 <reduce_angle_to_pi>
    12dc:	68050553          	.insn	4, 0x68050553
    12e0:	03412483          	lw	x9,52(x2)
    12e4:	03012903          	lw	x18,48(x2)
    12e8:	02c12407          	flw	f8,44(x2)
    12ec:	d91ff06f          	jal	x0,107c <f_parse_unary+0x248>
    12f0:	00190913          	addi	x18,x18,1
    12f4:	00040513          	addi	x10,x8,0
    12f8:	01242023          	sw	x18,0(x8)
    12fc:	00001097          	auipc	x1,0x1
    1300:	a34080e7          	jalr	x1,-1484(x1) # 1d30 <f_parse_expression>
    1304:	00042783          	lw	x15,0(x8)
    1308:	008006b7          	lui	x13,0x800
    130c:	01368693          	addi	x13,x13,19 # 800013 <_stack_ptr+0x7f0013>
    1310:	0007c583          	lbu	x11,0(x15)
    1314:	01700513          	addi	x10,x0,23
    1318:	20a506d3          	fsgnj.s	f13,f10,f10
    131c:	ff758713          	addi	x14,x11,-9
    1320:	0ff77713          	andi	x14,x14,255
    1324:	00e6d633          	srl	x12,x13,x14
    1328:	00167613          	andi	x12,x12,1
    132c:	02e56463          	bltu	x10,x14,1354 <f_parse_unary+0x520>
    1330:	00178793          	addi	x15,x15,1
    1334:	f2060ee3          	beq	x12,x0,1270 <f_parse_unary+0x43c>
    1338:	00f42023          	sw	x15,0(x8)
    133c:	0007c583          	lbu	x11,0(x15)
    1340:	ff758713          	addi	x14,x11,-9
    1344:	0ff77713          	andi	x14,x14,255
    1348:	00e6d633          	srl	x12,x13,x14
    134c:	00167613          	andi	x12,x12,1
    1350:	fee570e3          	bgeu	x10,x14,1330 <f_parse_unary+0x4fc>
    1354:	02900713          	addi	x14,x0,41
    1358:	f0e59ce3          	bne	x11,x14,1270 <f_parse_unary+0x43c>
    135c:	00178793          	addi	x15,x15,1
    1360:	00f42023          	sw	x15,0(x8)
    1364:	06c00793          	addi	x15,x0,108
    1368:	52f48263          	beq	x9,x15,188c <f_parse_unary+0xa58>
    136c:	07000793          	addi	x15,x0,112
    1370:	f0f490e3          	bne	x9,x15,1270 <f_parse_unary+0x43c>
    1374:	01114703          	lbu	x14,17(x2)
    1378:	06f00793          	addi	x15,x0,111
    137c:	eef71ae3          	bne	x14,x15,1270 <f_parse_unary+0x43c>
    1380:	01214703          	lbu	x14,18(x2)
    1384:	07700793          	addi	x15,x0,119
    1388:	eef714e3          	bne	x14,x15,1270 <f_parse_unary+0x43c>
    138c:	01314783          	lbu	x15,19(x2)
    1390:	ee0790e3          	bne	x15,x0,1270 <f_parse_unary+0x43c>
    1394:	f00007d3          	fmv.w.x	f15,x0
    1398:	a0f407d3          	fle.s	x15,f8,f15
    139c:	12079263          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    13a0:	000047b7          	lui	x15,0x4
    13a4:	cc47a707          	flw	f14,-828(x15) # 3cc4 <__clz_tab+0x144>
    13a8:	000047b7          	lui	x15,0x4
    13ac:	cd87a607          	flw	f12,-808(x15) # 3cd8 <__clz_tab+0x158>
    13b0:	08e477d3          	fsub.s	f15,f8,f14
    13b4:	00e47553          	fadd.s	f10,f8,f14
    13b8:	18a7f7d3          	fdiv.s	f15,f15,f10
    13bc:	a0c787d3          	fle.s	x15,f15,f12
    13c0:	10079063          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    13c4:	a0f707d3          	fle.s	x15,f14,f15
    13c8:	0e079c63          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    13cc:	000047b7          	lui	x15,0x4
    13d0:	cdc7a707          	flw	f14,-804(x15) # 3cdc <__clz_tab+0x15c>
    13d4:	a0f707d3          	fle.s	x15,f14,f15
    13d8:	0e078463          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    13dc:	800787d3          	.insn	4, 0x800787d3
    13e0:	00f7f7d3          	fadd.s	f15,f15,f15
    13e4:	10d7f7d3          	fmul.s	f15,f15,f13
    13e8:	a0f707d3          	fle.s	x15,f14,f15
    13ec:	0c078a63          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    13f0:	000047b7          	lui	x15,0x4
    13f4:	cf47a707          	flw	f14,-780(x15) # 3cf4 <__clz_tab+0x174>
    13f8:	a0e787d3          	fle.s	x15,f15,f14
    13fc:	0c078263          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1400:	78078553          	.insn	4, 0x78078553
    1404:	700787d3          	.insn	4, 0x700787d3
    1408:	00f57553          	fadd.s	f10,f10,f15
    140c:	03412483          	lw	x9,52(x2)
    1410:	03012903          	lw	x18,48(x2)
    1414:	02c12407          	flw	f8,44(x2)
    1418:	c65ff06f          	jal	x0,107c <f_parse_unary+0x248>
    141c:	01114683          	lbu	x13,17(x2)
    1420:	06f00713          	addi	x14,x0,111
    1424:	e4e692e3          	bne	x13,x14,1268 <f_parse_unary+0x434>
    1428:	01214703          	lbu	x14,18(x2)
    142c:	e2f71ee3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1430:	01314783          	lbu	x15,19(x2)
    1434:	58079063          	bne	x15,x0,19b4 <f_parse_unary+0xb80>
    1438:	02900793          	addi	x15,x0,41
    143c:	e2f59ae3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1440:	20840553          	fsgnj.s	f10,f8,f8
    1444:	00190913          	addi	x18,x18,1
    1448:	01242023          	sw	x18,0(x8)
    144c:	fffff097          	auipc	x1,0xfffff
    1450:	c6c080e7          	jalr	x1,-916(x1) # b8 <reduce_angle_to_pi>
    1454:	60050553          	.insn	4, 0x60050553
    1458:	03412483          	lw	x9,52(x2)
    145c:	03012903          	lw	x18,48(x2)
    1460:	02c12407          	flw	f8,44(x2)
    1464:	c19ff06f          	jal	x0,107c <f_parse_unary+0x248>
    1468:	06100693          	addi	x13,x0,97
    146c:	06d49a63          	bne	x9,x13,14e0 <f_parse_unary+0x6ac>
    1470:	01114683          	lbu	x13,17(x2)
    1474:	22f68a63          	beq	x13,x15,16a8 <f_parse_unary+0x874>
    1478:	14e69663          	bne	x13,x14,15c4 <f_parse_unary+0x790>
    147c:	01214683          	lbu	x13,18(x2)
    1480:	06f00713          	addi	x14,x0,111
    1484:	dee692e3          	bne	x13,x14,1268 <f_parse_unary+0x434>
    1488:	01314703          	lbu	x14,19(x2)
    148c:	dcf71ee3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1490:	01414783          	lbu	x15,20(x2)
    1494:	dc079ae3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    1498:	02900793          	addi	x15,x0,41
    149c:	dcf59ae3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    14a0:	000047b7          	lui	x15,0x4
    14a4:	cd87a787          	flw	f15,-808(x15) # 3cd8 <__clz_tab+0x158>
    14a8:	a0f417d3          	flt.s	x15,f8,f15
    14ac:	00079a63          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    14b0:	000047b7          	lui	x15,0x4
    14b4:	cc47a707          	flw	f14,-828(x15) # 3cc4 <__clz_tab+0x144>
    14b8:	a08717d3          	flt.s	x15,f14,f8
    14bc:	54078663          	beq	x15,x0,1a08 <f_parse_unary+0xbd4>
    14c0:	00100793          	addi	x15,x0,1
    14c4:	00f40323          	sb	x15,6(x8)
    14c8:	00f40223          	sb	x15,4(x8)
    14cc:	03412483          	lw	x9,52(x2)
    14d0:	03012903          	lw	x18,48(x2)
    14d4:	02c12407          	flw	f8,44(x2)
    14d8:	f0000553          	fmv.w.x	f10,x0
    14dc:	ba1ff06f          	jal	x0,107c <f_parse_unary+0x248>
    14e0:	06500793          	addi	x15,x0,101
    14e4:	06f49863          	bne	x9,x15,1554 <f_parse_unary+0x720>
    14e8:	01114703          	lbu	x14,17(x2)
    14ec:	07800793          	addi	x15,x0,120
    14f0:	d6f71ce3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    14f4:	01214703          	lbu	x14,18(x2)
    14f8:	07000793          	addi	x15,x0,112
    14fc:	d6f716e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1500:	01314783          	lbu	x15,19(x2)
    1504:	d60792e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    1508:	02900793          	addi	x15,x0,41
    150c:	d6f592e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1510:	000047b7          	lui	x15,0x4
    1514:	cdc7a787          	flw	f15,-804(x15) # 3cdc <__clz_tab+0x15c>
    1518:	a08787d3          	fle.s	x15,f15,f8
    151c:	fa0782e3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1520:	000047b7          	lui	x15,0x4
    1524:	cf47a787          	flw	f15,-780(x15) # 3cf4 <__clz_tab+0x174>
    1528:	a0f407d3          	fle.s	x15,f8,f15
    152c:	f8078ae3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1530:	780407d3          	.insn	4, 0x780407d3
    1534:	70040553          	.insn	4, 0x70040553
    1538:	00190913          	addi	x18,x18,1
    153c:	01242023          	sw	x18,0(x8)
    1540:	00a7f553          	fadd.s	f10,f15,f10
    1544:	03412483          	lw	x9,52(x2)
    1548:	03012903          	lw	x18,48(x2)
    154c:	02c12407          	flw	f8,44(x2)
    1550:	b2dff06f          	jal	x0,107c <f_parse_unary+0x248>
    1554:	06c00793          	addi	x15,x0,108
    1558:	d0f498e3          	bne	x9,x15,1268 <f_parse_unary+0x434>
    155c:	01114783          	lbu	x15,17(x2)
    1560:	06e00713          	addi	x14,x0,110
    1564:	2ae78863          	beq	x15,x14,1814 <f_parse_unary+0x9e0>
    1568:	06f00713          	addi	x14,x0,111
    156c:	cee79ee3          	bne	x15,x14,1268 <f_parse_unary+0x434>
    1570:	01214703          	lbu	x14,18(x2)
    1574:	06700793          	addi	x15,x0,103
    1578:	cef718e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    157c:	01314783          	lbu	x15,19(x2)
    1580:	03100713          	addi	x14,x0,49
    1584:	4ce78263          	beq	x15,x14,1a48 <f_parse_unary+0xc14>
    1588:	ce0790e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    158c:	02900793          	addi	x15,x0,41
    1590:	ccf59ce3          	bne	x11,x15,1268 <f_parse_unary+0x434>
    1594:	20840553          	fsgnj.s	f10,f8,f8
    1598:	00c10513          	addi	x10,x2,12
    159c:	fffff097          	auipc	x1,0xfffff
    15a0:	f10080e7          	jalr	x1,-240(x1) # 4ac <my_log10>
    15a4:	f0050ee3          	beq	x10,x0,14c0 <f_parse_unary+0x68c>
    15a8:	00190913          	addi	x18,x18,1
    15ac:	01242023          	sw	x18,0(x8)
    15b0:	00c12507          	flw	f10,12(x2)
    15b4:	03412483          	lw	x9,52(x2)
    15b8:	03012903          	lw	x18,48(x2)
    15bc:	02c12407          	flw	f8,44(x2)
    15c0:	abdff06f          	jal	x0,107c <f_parse_unary+0x248>
    15c4:	20c68e63          	beq	x13,x12,17e0 <f_parse_unary+0x9ac>
    15c8:	07200793          	addi	x15,x0,114
    15cc:	c8f69ee3          	bne	x13,x15,1268 <f_parse_unary+0x434>
    15d0:	01214783          	lbu	x15,18(x2)
    15d4:	c8e79ae3          	bne	x15,x14,1268 <f_parse_unary+0x434>
    15d8:	01314783          	lbu	x15,19(x2)
    15dc:	c8c796e3          	bne	x15,x12,1268 <f_parse_unary+0x434>
    15e0:	01414703          	lbu	x14,20(x2)
    15e4:	06100793          	addi	x15,x0,97
    15e8:	c8f710e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    15ec:	01514703          	lbu	x14,21(x2)
    15f0:	06e00793          	addi	x15,x0,110
    15f4:	c6f71ae3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    15f8:	01614703          	lbu	x14,22(x2)
    15fc:	06800793          	addi	x15,x0,104
    1600:	c6f714e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1604:	01714783          	lbu	x15,23(x2)
    1608:	c60790e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    160c:	02900793          	addi	x15,x0,41
    1610:	c6f590e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1614:	f00007d3          	fmv.w.x	f15,x0
    1618:	a0f417d3          	flt.s	x15,f8,f15
    161c:	208407d3          	fsgnj.s	f15,f8,f8
    1620:	00078463          	beq	x15,x0,1628 <f_parse_unary+0x7f4>
    1624:	208417d3          	fsgnjn.s	f15,f8,f8
    1628:	000047b7          	lui	x15,0x4
    162c:	cc47a707          	flw	f14,-828(x15) # 3cc4 <__clz_tab+0x144>
    1630:	a0f707d3          	fle.s	x15,f14,f15
    1634:	e80796e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    1638:	000047b7          	lui	x15,0x4
    163c:	cdc7a787          	flw	f15,-804(x15) # 3cdc <__clz_tab+0x15c>
    1640:	a08787d3          	fle.s	x15,f15,f8
    1644:	e6078ee3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1648:	000047b7          	lui	x15,0x4
    164c:	cf47a787          	flw	f15,-780(x15) # 3cf4 <__clz_tab+0x174>
    1650:	a0f407d3          	fle.s	x15,f8,f15
    1654:	e60786e3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1658:	00190913          	addi	x18,x18,1
    165c:	01242023          	sw	x18,0(x8)
    1660:	80040553          	.insn	4, 0x80040553
    1664:	03412483          	lw	x9,52(x2)
    1668:	03012903          	lw	x18,48(x2)
    166c:	02c12407          	flw	f8,44(x2)
    1670:	a0dff06f          	jal	x0,107c <f_parse_unary+0x248>
    1674:	00178713          	addi	x14,x15,1
    1678:	00e42023          	sw	x14,0(x8)
    167c:	0017c703          	lbu	x14,1(x15)
    1680:	f0000553          	fmv.w.x	f10,x0
    1684:	fd070713          	addi	x14,x14,-48
    1688:	0ff77713          	andi	x14,x14,255
    168c:	a0e67ce3          	bgeu	x12,x14,10a4 <f_parse_unary+0x270>
    1690:	00100793          	addi	x15,x0,1
    1694:	00f40223          	sb	x15,4(x8)
    1698:	03c12083          	lw	x1,60(x2)
    169c:	03812403          	lw	x8,56(x2)
    16a0:	04010113          	addi	x2,x2,64
    16a4:	00008067          	jalr	x0,0(x1)
    16a8:	01214703          	lbu	x14,18(x2)
    16ac:	06900793          	addi	x15,x0,105
    16b0:	baf71ce3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    16b4:	01314703          	lbu	x14,19(x2)
    16b8:	06e00793          	addi	x15,x0,110
    16bc:	baf716e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    16c0:	01414783          	lbu	x15,20(x2)
    16c4:	ba0792e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    16c8:	02900793          	addi	x15,x0,41
    16cc:	baf592e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    16d0:	000047b7          	lui	x15,0x4
    16d4:	cd87a787          	flw	f15,-808(x15) # 3cd8 <__clz_tab+0x158>
    16d8:	a0f417d3          	flt.s	x15,f8,f15
    16dc:	de0792e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    16e0:	000047b7          	lui	x15,0x4
    16e4:	cc47a787          	flw	f15,-828(x15) # 3cc4 <__clz_tab+0x144>
    16e8:	a08797d3          	flt.s	x15,f15,f8
    16ec:	dc079ae3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    16f0:	00190913          	addi	x18,x18,1
    16f4:	01242023          	sw	x18,0(x8)
    16f8:	03812403          	lw	x8,56(x2)
    16fc:	03412483          	lw	x9,52(x2)
    1700:	03012903          	lw	x18,48(x2)
    1704:	03c12083          	lw	x1,60(x2)
    1708:	20840553          	fsgnj.s	f10,f8,f8
    170c:	02c12407          	flw	f8,44(x2)
    1710:	04010113          	addi	x2,x2,64
    1714:	fffff317          	auipc	x6,0xfffff
    1718:	bf830067          	jalr	x0,-1032(x6) # 30c <my_asin.part.0>
    171c:	01214703          	lbu	x14,18(x2)
    1720:	07200793          	addi	x15,x0,114
    1724:	b4f712e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1728:	01314703          	lbu	x14,19(x2)
    172c:	07400793          	addi	x15,x0,116
    1730:	b2f71ce3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1734:	01414783          	lbu	x15,20(x2)
    1738:	b20798e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    173c:	02900793          	addi	x15,x0,41
    1740:	b2f598e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1744:	f00007d3          	fmv.w.x	f15,x0
    1748:	a0f417d3          	flt.s	x15,f8,f15
    174c:	d6079ae3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    1750:	00190913          	addi	x18,x18,1
    1754:	01242023          	sw	x18,0(x8)
    1758:	58047553          	fsqrt.s	f10,f8
    175c:	03412483          	lw	x9,52(x2)
    1760:	03012903          	lw	x18,48(x2)
    1764:	02c12407          	flw	f8,44(x2)
    1768:	915ff06f          	jal	x0,107c <f_parse_unary+0x248>
    176c:	01214703          	lbu	x14,18(x2)
    1770:	06e00793          	addi	x15,x0,110
    1774:	aef71ae3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1778:	01314783          	lbu	x15,19(x2)
    177c:	ae0796e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    1780:	02900793          	addi	x15,x0,41
    1784:	aef596e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1788:	20840553          	fsgnj.s	f10,f8,f8
    178c:	fffff097          	auipc	x1,0xfffff
    1790:	92c080e7          	jalr	x1,-1748(x1) # b8 <reduce_angle_to_pi>
    1794:	20a507d3          	fsgnj.s	f15,f10,f10
    1798:	60050753          	.insn	4, 0x60050753
    179c:	f00006d3          	fmv.w.x	f13,x0
    17a0:	a0d717d3          	flt.s	x15,f14,f13
    17a4:	00078463          	beq	x15,x0,17ac <f_parse_unary+0x978>
    17a8:	20e71753          	fsgnjn.s	f14,f14,f14
    17ac:	000047b7          	lui	x15,0x4
    17b0:	cf07a687          	flw	f13,-784(x15) # 3cf0 <__clz_tab+0x170>
    17b4:	a0d717d3          	flt.s	x15,f14,f13
    17b8:	d00794e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    17bc:	00190913          	addi	x18,x18,1
    17c0:	01242023          	sw	x18,0(x8)
    17c4:	68078553          	.insn	4, 0x68078553
    17c8:	600787d3          	.insn	4, 0x600787d3
    17cc:	18f57553          	fdiv.s	f10,f10,f15
    17d0:	03412483          	lw	x9,52(x2)
    17d4:	03012903          	lw	x18,48(x2)
    17d8:	02c12407          	flw	f8,44(x2)
    17dc:	8a1ff06f          	jal	x0,107c <f_parse_unary+0x248>
    17e0:	01214783          	lbu	x15,18(x2)
    17e4:	a89792e3          	bne	x15,x9,1268 <f_parse_unary+0x434>
    17e8:	01314703          	lbu	x14,19(x2)
    17ec:	06e00693          	addi	x13,x0,110
    17f0:	26d70c63          	beq	x14,x13,1a68 <f_parse_unary+0xc34>
    17f4:	06e00793          	addi	x15,x0,110
    17f8:	a6f718e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    17fc:	01414703          	lbu	x14,20(x2)
    1800:	06800793          	addi	x15,x0,104
    1804:	a6f712e3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1808:	01514783          	lbu	x15,21(x2)
    180c:	a4079ee3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    1810:	dfdff06f          	jal	x0,160c <f_parse_unary+0x7d8>
    1814:	01214783          	lbu	x15,18(x2)
    1818:	a40798e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    181c:	02900793          	addi	x15,x0,41
    1820:	a4f598e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1824:	f00007d3          	fmv.w.x	f15,x0
    1828:	a0f407d3          	fle.s	x15,f8,f15
    182c:	c8079ae3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    1830:	000047b7          	lui	x15,0x4
    1834:	cc47a707          	flw	f14,-828(x15) # 3cc4 <__clz_tab+0x144>
    1838:	000047b7          	lui	x15,0x4
    183c:	08e476d3          	fsub.s	f13,f8,f14
    1840:	00e477d3          	fadd.s	f15,f8,f14
    1844:	18f6f7d3          	fdiv.s	f15,f13,f15
    1848:	cd87a687          	flw	f13,-808(x15) # 3cd8 <__clz_tab+0x158>
    184c:	a0d787d3          	fle.s	x15,f15,f13
    1850:	c60798e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    1854:	a0f707d3          	fle.s	x15,f14,f15
    1858:	c60794e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    185c:	000047b7          	lui	x15,0x4
    1860:	cdc7a707          	flw	f14,-804(x15) # 3cdc <__clz_tab+0x15c>
    1864:	a0f707d3          	fle.s	x15,f14,f15
    1868:	c4078ce3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    186c:	80078553          	.insn	4, 0x80078553
    1870:	00190913          	addi	x18,x18,1
    1874:	01242023          	sw	x18,0(x8)
    1878:	00a57553          	fadd.s	f10,f10,f10
    187c:	03412483          	lw	x9,52(x2)
    1880:	03012903          	lw	x18,48(x2)
    1884:	02c12407          	flw	f8,44(x2)
    1888:	ff4ff06f          	jal	x0,107c <f_parse_unary+0x248>
    188c:	01114703          	lbu	x14,17(x2)
    1890:	06f00793          	addi	x15,x0,111
    1894:	9cf71ee3          	bne	x14,x15,1270 <f_parse_unary+0x43c>
    1898:	01214703          	lbu	x14,18(x2)
    189c:	06700793          	addi	x15,x0,103
    18a0:	9cf718e3          	bne	x14,x15,1270 <f_parse_unary+0x43c>
    18a4:	01314783          	lbu	x15,19(x2)
    18a8:	9c0794e3          	bne	x15,x0,1270 <f_parse_unary+0x43c>
    18ac:	f00007d3          	fmv.w.x	f15,x0
    18b0:	a0f407d3          	fle.s	x15,f8,f15
    18b4:	c00796e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    18b8:	00004737          	lui	x14,0x4
    18bc:	cc472707          	flw	f14,-828(x14) # 3cc4 <__clz_tab+0x144>
    18c0:	a0e427d3          	feq.s	x15,f8,f14
    18c4:	be079ee3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    18c8:	a0f687d3          	fle.s	x15,f13,f15
    18cc:	be079ae3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    18d0:	08e477d3          	fsub.s	f15,f8,f14
    18d4:	00e47753          	fadd.s	f14,f8,f14
    18d8:	000047b7          	lui	x15,0x4
    18dc:	cd87a607          	flw	f12,-808(x15) # 3cd8 <__clz_tab+0x158>
    18e0:	18e7f7d3          	fdiv.s	f15,f15,f14
    18e4:	a0c786d3          	fle.s	x13,f15,f12
    18e8:	bc069ce3          	bne	x13,x0,14c0 <f_parse_unary+0x68c>
    18ec:	cc472607          	flw	f12,-828(x14)
    18f0:	a0f60753          	fle.s	x14,f12,f15
    18f4:	bc0716e3          	bne	x14,x0,14c0 <f_parse_unary+0x68c>
    18f8:	00004737          	lui	x14,0x4
    18fc:	cdc72587          	flw	f11,-804(x14) # 3cdc <__clz_tab+0x15c>
    1900:	a0f58753          	fle.s	x14,f11,f15
    1904:	ba070ee3          	beq	x14,x0,14c0 <f_parse_unary+0x68c>
    1908:	80078753          	.insn	4, 0x80078753
    190c:	00e77753          	fadd.s	f14,f14,f14
    1910:	f00007d3          	fmv.w.x	f15,x0
    1914:	a0f72753          	feq.s	x14,f14,f15
    1918:	ba0714e3          	bne	x14,x0,14c0 <f_parse_unary+0x68c>
    191c:	08c6f7d3          	fsub.s	f15,f13,f12
    1920:	00c6f6d3          	fadd.s	f13,f13,f12
    1924:	cd87a507          	flw	f10,-808(x15)
    1928:	18d7f7d3          	fdiv.s	f15,f15,f13
    192c:	a0a787d3          	fle.s	x15,f15,f10
    1930:	b80798e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    1934:	a0f607d3          	fle.s	x15,f12,f15
    1938:	b80794e3          	bne	x15,x0,14c0 <f_parse_unary+0x68c>
    193c:	a0f587d3          	fle.s	x15,f11,f15
    1940:	b80780e3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1944:	80078553          	.insn	4, 0x80078553
    1948:	00a57553          	fadd.s	f10,f10,f10
    194c:	03412483          	lw	x9,52(x2)
    1950:	03012903          	lw	x18,48(x2)
    1954:	02c12407          	flw	f8,44(x2)
    1958:	18e57553          	fdiv.s	f10,f10,f14
    195c:	f20ff06f          	jal	x0,107c <f_parse_unary+0x248>
    1960:	06800713          	addi	x14,x0,104
    1964:	90e792e3          	bne	x15,x14,1268 <f_parse_unary+0x434>
    1968:	01414783          	lbu	x15,20(x2)
    196c:	8e079ee3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    1970:	02900793          	addi	x15,x0,41
    1974:	8ef59ee3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1978:	000047b7          	lui	x15,0x4
    197c:	cdc7a787          	flw	f15,-804(x15) # 3cdc <__clz_tab+0x15c>
    1980:	a08787d3          	fle.s	x15,f15,f8
    1984:	b2078ee3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1988:	000047b7          	lui	x15,0x4
    198c:	cf47a787          	flw	f15,-780(x15) # 3cf4 <__clz_tab+0x174>
    1990:	a0f407d3          	fle.s	x15,f8,f15
    1994:	b20786e3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    1998:	00190913          	addi	x18,x18,1
    199c:	01242023          	sw	x18,0(x8)
    19a0:	78040553          	.insn	4, 0x78040553
    19a4:	03412483          	lw	x9,52(x2)
    19a8:	03012903          	lw	x18,48(x2)
    19ac:	02c12407          	flw	f8,44(x2)
    19b0:	eccff06f          	jal	x0,107c <f_parse_unary+0x248>
    19b4:	06800713          	addi	x14,x0,104
    19b8:	8ae798e3          	bne	x15,x14,1268 <f_parse_unary+0x434>
    19bc:	01414783          	lbu	x15,20(x2)
    19c0:	8a0794e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    19c4:	02900793          	addi	x15,x0,41
    19c8:	8af594e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    19cc:	000047b7          	lui	x15,0x4
    19d0:	cdc7a787          	flw	f15,-804(x15) # 3cdc <__clz_tab+0x15c>
    19d4:	a08787d3          	fle.s	x15,f15,f8
    19d8:	ae0784e3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    19dc:	000047b7          	lui	x15,0x4
    19e0:	cf47a787          	flw	f15,-780(x15) # 3cf4 <__clz_tab+0x174>
    19e4:	a0f407d3          	fle.s	x15,f8,f15
    19e8:	ac078ce3          	beq	x15,x0,14c0 <f_parse_unary+0x68c>
    19ec:	00190913          	addi	x18,x18,1
    19f0:	01242023          	sw	x18,0(x8)
    19f4:	70040553          	.insn	4, 0x70040553
    19f8:	03412483          	lw	x9,52(x2)
    19fc:	03012903          	lw	x18,48(x2)
    1a00:	02c12407          	flw	f8,44(x2)
    1a04:	e78ff06f          	jal	x0,107c <f_parse_unary+0x248>
    1a08:	a08707d3          	fle.s	x15,f14,f8
    1a0c:	00190913          	addi	x18,x18,1
    1a10:	01242023          	sw	x18,0(x8)
    1a14:	0a079463          	bne	x15,x0,1abc <f_parse_unary+0xc88>
    1a18:	a0f407d3          	fle.s	x15,f8,f15
    1a1c:	08079a63          	bne	x15,x0,1ab0 <f_parse_unary+0xc7c>
    1a20:	20840553          	fsgnj.s	f10,f8,f8
    1a24:	fffff097          	auipc	x1,0xfffff
    1a28:	8e8080e7          	jalr	x1,-1816(x1) # 30c <my_asin.part.0>
    1a2c:	000047b7          	lui	x15,0x4
    1a30:	cd07a787          	flw	f15,-816(x15) # 3cd0 <__clz_tab+0x150>
    1a34:	03412483          	lw	x9,52(x2)
    1a38:	03012903          	lw	x18,48(x2)
    1a3c:	08a7f553          	fsub.s	f10,f15,f10
    1a40:	02c12407          	flw	f8,44(x2)
    1a44:	e38ff06f          	jal	x0,107c <f_parse_unary+0x248>
    1a48:	01414703          	lbu	x14,20(x2)
    1a4c:	03000793          	addi	x15,x0,48
    1a50:	80f71ce3          	bne	x14,x15,1268 <f_parse_unary+0x434>
    1a54:	01514783          	lbu	x15,21(x2)
    1a58:	800798e3          	bne	x15,x0,1268 <f_parse_unary+0x434>
    1a5c:	02900793          	addi	x15,x0,41
    1a60:	80f598e3          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1a64:	b31ff06f          	jal	x0,1594 <f_parse_unary+0x760>
    1a68:	01414683          	lbu	x13,20(x2)
    1a6c:	02069c63          	bne	x13,x0,1aa4 <f_parse_unary+0xc70>
    1a70:	02900793          	addi	x15,x0,41
    1a74:	fef59e63          	bne	x11,x15,1270 <f_parse_unary+0x43c>
    1a78:	00190913          	addi	x18,x18,1
    1a7c:	01242023          	sw	x18,0(x8)
    1a80:	03812403          	lw	x8,56(x2)
    1a84:	03412483          	lw	x9,52(x2)
    1a88:	03012903          	lw	x18,48(x2)
    1a8c:	03c12083          	lw	x1,60(x2)
    1a90:	20840553          	fsgnj.s	f10,f8,f8
    1a94:	02c12407          	flw	f8,44(x2)
    1a98:	04010113          	addi	x2,x2,64
    1a9c:	ffffe317          	auipc	x6,0xffffe
    1aa0:	78c30067          	jalr	x0,1932(x6) # 228 <my_atan>
    1aa4:	06100693          	addi	x13,x0,97
    1aa8:	d4d786e3          	beq	x15,x13,17f4 <f_parse_unary+0x9c0>
    1aac:	fbcff06f          	jal	x0,1268 <f_parse_unary+0x434>
    1ab0:	03012903          	lw	x18,48(x2)
    1ab4:	02c12407          	flw	f8,44(x2)
    1ab8:	fd0ff06f          	jal	x0,1288 <f_parse_unary+0x454>
    1abc:	03412483          	lw	x9,52(x2)
    1ac0:	03012903          	lw	x18,48(x2)
    1ac4:	02c12407          	flw	f8,44(x2)
    1ac8:	f0000553          	fmv.w.x	f10,x0
    1acc:	db0ff06f          	jal	x0,107c <f_parse_unary+0x248>

00001ad0 <f_parse_power>:
    1ad0:	fe010113          	addi	x2,x2,-32
    1ad4:	00812c23          	sw	x8,24(x2)
    1ad8:	00812627          	fsw	f8,12(x2)
    1adc:	00050413          	addi	x8,x10,0
    1ae0:	00112e23          	sw	x1,28(x2)
    1ae4:	fffff097          	auipc	x1,0xfffff
    1ae8:	350080e7          	jalr	x1,848(x1) # e34 <f_parse_unary>
    1aec:	00042703          	lw	x14,0(x8)
    1af0:	00800637          	lui	x12,0x800
    1af4:	01360613          	addi	x12,x12,19 # 800013 <_stack_ptr+0x7f0013>
    1af8:	00074583          	lbu	x11,0(x14)
    1afc:	01700513          	addi	x10,x0,23
    1b00:	20a50453          	fsgnj.s	f8,f10,f10
    1b04:	ff758793          	addi	x15,x11,-9
    1b08:	0ff7f793          	andi	x15,x15,255
    1b0c:	00f656b3          	srl	x13,x12,x15
    1b10:	0016f693          	andi	x13,x13,1
    1b14:	02f56463          	bltu	x10,x15,1b3c <f_parse_power+0x6c>
    1b18:	00170713          	addi	x14,x14,1
    1b1c:	04068463          	beq	x13,x0,1b64 <f_parse_power+0x94>
    1b20:	00e42023          	sw	x14,0(x8)
    1b24:	00074583          	lbu	x11,0(x14)
    1b28:	ff758793          	addi	x15,x11,-9
    1b2c:	0ff7f793          	andi	x15,x15,255
    1b30:	00f656b3          	srl	x13,x12,x15
    1b34:	0016f693          	andi	x13,x13,1
    1b38:	fef570e3          	bgeu	x10,x15,1b18 <f_parse_power+0x48>
    1b3c:	05e00793          	addi	x15,x0,94
    1b40:	02f59263          	bne	x11,x15,1b64 <f_parse_power+0x94>
    1b44:	00170713          	addi	x14,x14,1
    1b48:	00e42023          	sw	x14,0(x8)
    1b4c:	00040513          	addi	x10,x8,0
    1b50:	00000097          	auipc	x1,0x0
    1b54:	f80080e7          	jalr	x1,-128(x1) # 1ad0 <f_parse_power>
    1b58:	00444783          	lbu	x15,4(x8)
    1b5c:	02078063          	beq	x15,x0,1b7c <f_parse_power+0xac>
    1b60:	f0000453          	fmv.w.x	f8,x0
    1b64:	01c12083          	lw	x1,28(x2)
    1b68:	01812403          	lw	x8,24(x2)
    1b6c:	20840553          	fsgnj.s	f10,f8,f8
    1b70:	00c12407          	flw	f8,12(x2)
    1b74:	02010113          	addi	x2,x2,32
    1b78:	00008067          	jalr	x0,0(x1)
    1b7c:	f00007d3          	fmv.w.x	f15,x0
    1b80:	a0f407d3          	fle.s	x15,f8,f15
    1b84:	06079a63          	bne	x15,x0,1bf8 <f_parse_power+0x128>
    1b88:	000047b7          	lui	x15,0x4
    1b8c:	cc47a707          	flw	f14,-828(x15) # 3cc4 <__clz_tab+0x144>
    1b90:	000047b7          	lui	x15,0x4
    1b94:	cd87a687          	flw	f13,-808(x15) # 3cd8 <__clz_tab+0x158>
    1b98:	08e477d3          	fsub.s	f15,f8,f14
    1b9c:	00e47453          	fadd.s	f8,f8,f14
    1ba0:	1887f7d3          	fdiv.s	f15,f15,f8
    1ba4:	a0d787d3          	fle.s	x15,f15,f13
    1ba8:	04079863          	bne	x15,x0,1bf8 <f_parse_power+0x128>
    1bac:	a0f707d3          	fle.s	x15,f14,f15
    1bb0:	04079463          	bne	x15,x0,1bf8 <f_parse_power+0x128>
    1bb4:	000047b7          	lui	x15,0x4
    1bb8:	cdc7a707          	flw	f14,-804(x15) # 3cdc <__clz_tab+0x15c>
    1bbc:	a0f707d3          	fle.s	x15,f14,f15
    1bc0:	02078c63          	beq	x15,x0,1bf8 <f_parse_power+0x128>
    1bc4:	800787d3          	.insn	4, 0x800787d3
    1bc8:	00f7f7d3          	fadd.s	f15,f15,f15
    1bcc:	10a7f7d3          	fmul.s	f15,f15,f10
    1bd0:	a0f707d3          	fle.s	x15,f14,f15
    1bd4:	02078263          	beq	x15,x0,1bf8 <f_parse_power+0x128>
    1bd8:	000047b7          	lui	x15,0x4
    1bdc:	cf47a707          	flw	f14,-780(x15) # 3cf4 <__clz_tab+0x174>
    1be0:	a0e787d3          	fle.s	x15,f15,f14
    1be4:	00078a63          	beq	x15,x0,1bf8 <f_parse_power+0x128>
    1be8:	78078453          	.insn	4, 0x78078453
    1bec:	700787d3          	.insn	4, 0x700787d3
    1bf0:	00f47453          	fadd.s	f8,f8,f15
    1bf4:	f71ff06f          	jal	x0,1b64 <f_parse_power+0x94>
    1bf8:	00100793          	addi	x15,x0,1
    1bfc:	f0000453          	fmv.w.x	f8,x0
    1c00:	00f40323          	sb	x15,6(x8)
    1c04:	00f40223          	sb	x15,4(x8)
    1c08:	f5dff06f          	jal	x0,1b64 <f_parse_power+0x94>

00001c0c <f_parse_term>:
    1c0c:	fd010113          	addi	x2,x2,-48
    1c10:	02812423          	sw	x8,40(x2)
    1c14:	00812627          	fsw	f8,12(x2)
    1c18:	00050413          	addi	x8,x10,0
    1c1c:	02112623          	sw	x1,44(x2)
    1c20:	00000097          	auipc	x1,0x0
    1c24:	eb0080e7          	jalr	x1,-336(x1) # 1ad0 <f_parse_power>
    1c28:	00444783          	lbu	x15,4(x8)
    1c2c:	20a50453          	fsgnj.s	f8,f10,f10
    1c30:	0c079263          	bne	x15,x0,1cf4 <f_parse_term+0xe8>
    1c34:	00912427          	fsw	f9,8(x2)
    1c38:	f00004d3          	fmv.w.x	f9,x0
    1c3c:	02912223          	sw	x9,36(x2)
    1c40:	008004b7          	lui	x9,0x800
    1c44:	03212023          	sw	x18,32(x2)
    1c48:	01312e23          	sw	x19,28(x2)
    1c4c:	01412c23          	sw	x20,24(x2)
    1c50:	01348493          	addi	x9,x9,19 # 800013 <_stack_ptr+0x7f0013>
    1c54:	01700a13          	addi	x20,x0,23
    1c58:	02a00913          	addi	x18,x0,42
    1c5c:	02f00993          	addi	x19,x0,47
    1c60:	00042703          	lw	x14,0(x8)
    1c64:	00074603          	lbu	x12,0(x14)
    1c68:	ff760793          	addi	x15,x12,-9
    1c6c:	0ff7f793          	andi	x15,x15,255
    1c70:	00f4d6b3          	srl	x13,x9,x15
    1c74:	0016f693          	andi	x13,x13,1
    1c78:	02fa6463          	bltu	x20,x15,1ca0 <f_parse_term+0x94>
    1c7c:	00170713          	addi	x14,x14,1
    1c80:	06068063          	beq	x13,x0,1ce0 <f_parse_term+0xd4>
    1c84:	00e42023          	sw	x14,0(x8)
    1c88:	00074603          	lbu	x12,0(x14)
    1c8c:	ff760793          	addi	x15,x12,-9
    1c90:	0ff7f793          	andi	x15,x15,255
    1c94:	00f4d6b3          	srl	x13,x9,x15
    1c98:	0016f693          	andi	x13,x13,1
    1c9c:	fefa70e3          	bgeu	x20,x15,1c7c <f_parse_term+0x70>
    1ca0:	07260663          	beq	x12,x18,1d0c <f_parse_term+0x100>
    1ca4:	03361e63          	bne	x12,x19,1ce0 <f_parse_term+0xd4>
    1ca8:	00170713          	addi	x14,x14,1
    1cac:	00e42023          	sw	x14,0(x8)
    1cb0:	00040513          	addi	x10,x8,0
    1cb4:	00000097          	auipc	x1,0x0
    1cb8:	e1c080e7          	jalr	x1,-484(x1) # 1ad0 <f_parse_power>
    1cbc:	00444783          	lbu	x15,4(x8)
    1cc0:	00079e63          	bne	x15,x0,1cdc <f_parse_term+0xd0>
    1cc4:	a09527d3          	feq.s	x15,f10,f9
    1cc8:	00079663          	bne	x15,x0,1cd4 <f_parse_term+0xc8>
    1ccc:	18a47453          	fdiv.s	f8,f8,f10
    1cd0:	f91ff06f          	jal	x0,1c60 <f_parse_term+0x54>
    1cd4:	10100793          	addi	x15,x0,257
    1cd8:	00f41223          	sh	x15,4(x8)
    1cdc:	f0000453          	fmv.w.x	f8,x0
    1ce0:	02412483          	lw	x9,36(x2)
    1ce4:	02012903          	lw	x18,32(x2)
    1ce8:	01c12983          	lw	x19,28(x2)
    1cec:	01812a03          	lw	x20,24(x2)
    1cf0:	00812487          	flw	f9,8(x2)
    1cf4:	02c12083          	lw	x1,44(x2)
    1cf8:	02812403          	lw	x8,40(x2)
    1cfc:	20840553          	fsgnj.s	f10,f8,f8
    1d00:	00c12407          	flw	f8,12(x2)
    1d04:	03010113          	addi	x2,x2,48
    1d08:	00008067          	jalr	x0,0(x1)
    1d0c:	00170713          	addi	x14,x14,1
    1d10:	00e42023          	sw	x14,0(x8)
    1d14:	00040513          	addi	x10,x8,0
    1d18:	00000097          	auipc	x1,0x0
    1d1c:	db8080e7          	jalr	x1,-584(x1) # 1ad0 <f_parse_power>
    1d20:	00444783          	lbu	x15,4(x8)
    1d24:	fa079ce3          	bne	x15,x0,1cdc <f_parse_term+0xd0>
    1d28:	10a47453          	fmul.s	f8,f8,f10
    1d2c:	f35ff06f          	jal	x0,1c60 <f_parse_term+0x54>

00001d30 <f_parse_expression>:
    1d30:	fd010113          	addi	x2,x2,-48
    1d34:	02812423          	sw	x8,40(x2)
    1d38:	00812627          	fsw	f8,12(x2)
    1d3c:	00050413          	addi	x8,x10,0
    1d40:	02112623          	sw	x1,44(x2)
    1d44:	00000097          	auipc	x1,0x0
    1d48:	ec8080e7          	jalr	x1,-312(x1) # 1c0c <f_parse_term>
    1d4c:	00444783          	lbu	x15,4(x8)
    1d50:	20a50453          	fsgnj.s	f8,f10,f10
    1d54:	0a079263          	bne	x15,x0,1df8 <f_parse_expression+0xc8>
    1d58:	02912223          	sw	x9,36(x2)
    1d5c:	008004b7          	lui	x9,0x800
    1d60:	03212023          	sw	x18,32(x2)
    1d64:	01312e23          	sw	x19,28(x2)
    1d68:	01412c23          	sw	x20,24(x2)
    1d6c:	01348493          	addi	x9,x9,19 # 800013 <_stack_ptr+0x7f0013>
    1d70:	01700a13          	addi	x20,x0,23
    1d74:	02b00913          	addi	x18,x0,43
    1d78:	02d00993          	addi	x19,x0,45
    1d7c:	00042703          	lw	x14,0(x8)
    1d80:	00074603          	lbu	x12,0(x14)
    1d84:	ff760793          	addi	x15,x12,-9
    1d88:	0ff7f793          	andi	x15,x15,255
    1d8c:	00f4d6b3          	srl	x13,x9,x15
    1d90:	0016f693          	andi	x13,x13,1
    1d94:	02fa6463          	bltu	x20,x15,1dbc <f_parse_expression+0x8c>
    1d98:	00170713          	addi	x14,x14,1
    1d9c:	04068663          	beq	x13,x0,1de8 <f_parse_expression+0xb8>
    1da0:	00e42023          	sw	x14,0(x8)
    1da4:	00074603          	lbu	x12,0(x14)
    1da8:	ff760793          	addi	x15,x12,-9
    1dac:	0ff7f793          	andi	x15,x15,255
    1db0:	00f4d6b3          	srl	x13,x9,x15
    1db4:	0016f693          	andi	x13,x13,1
    1db8:	fefa70e3          	bgeu	x20,x15,1d98 <f_parse_expression+0x68>
    1dbc:	05260a63          	beq	x12,x18,1e10 <f_parse_expression+0xe0>
    1dc0:	03361463          	bne	x12,x19,1de8 <f_parse_expression+0xb8>
    1dc4:	00170713          	addi	x14,x14,1
    1dc8:	00e42023          	sw	x14,0(x8)
    1dcc:	00040513          	addi	x10,x8,0
    1dd0:	00000097          	auipc	x1,0x0
    1dd4:	e3c080e7          	jalr	x1,-452(x1) # 1c0c <f_parse_term>
    1dd8:	00444783          	lbu	x15,4(x8)
    1ddc:	04079c63          	bne	x15,x0,1e34 <f_parse_expression+0x104>
    1de0:	08a47453          	fsub.s	f8,f8,f10
    1de4:	f99ff06f          	jal	x0,1d7c <f_parse_expression+0x4c>
    1de8:	02412483          	lw	x9,36(x2)
    1dec:	02012903          	lw	x18,32(x2)
    1df0:	01c12983          	lw	x19,28(x2)
    1df4:	01812a03          	lw	x20,24(x2)
    1df8:	02c12083          	lw	x1,44(x2)
    1dfc:	02812403          	lw	x8,40(x2)
    1e00:	20840553          	fsgnj.s	f10,f8,f8
    1e04:	00c12407          	flw	f8,12(x2)
    1e08:	03010113          	addi	x2,x2,48
    1e0c:	00008067          	jalr	x0,0(x1)
    1e10:	00170713          	addi	x14,x14,1
    1e14:	00e42023          	sw	x14,0(x8)
    1e18:	00040513          	addi	x10,x8,0
    1e1c:	00000097          	auipc	x1,0x0
    1e20:	df0080e7          	jalr	x1,-528(x1) # 1c0c <f_parse_term>
    1e24:	00444783          	lbu	x15,4(x8)
    1e28:	00079663          	bne	x15,x0,1e34 <f_parse_expression+0x104>
    1e2c:	00a47453          	fadd.s	f8,f8,f10
    1e30:	f4dff06f          	jal	x0,1d7c <f_parse_expression+0x4c>
    1e34:	f0000453          	fmv.w.x	f8,x0
    1e38:	02c12083          	lw	x1,44(x2)
    1e3c:	02812403          	lw	x8,40(x2)
    1e40:	02412483          	lw	x9,36(x2)
    1e44:	02012903          	lw	x18,32(x2)
    1e48:	01c12983          	lw	x19,28(x2)
    1e4c:	01812a03          	lw	x20,24(x2)
    1e50:	20840553          	fsgnj.s	f10,f8,f8
    1e54:	00c12407          	flw	f8,12(x2)
    1e58:	03010113          	addi	x2,x2,48
    1e5c:	00008067          	jalr	x0,0(x1)

00001e60 <__lshrdi3>:
    1e60:	02060063          	beq	x12,x0,1e80 <__lshrdi3+0x20>
    1e64:	02000793          	addi	x15,x0,32
    1e68:	40c787b3          	sub	x15,x15,x12
    1e6c:	00f04c63          	blt	x0,x15,1e84 <__lshrdi3+0x24>
    1e70:	fe060613          	addi	x12,x12,-32
    1e74:	00c5d533          	srl	x10,x11,x12
    1e78:	00000713          	addi	x14,x0,0
    1e7c:	00070593          	addi	x11,x14,0
    1e80:	00008067          	jalr	x0,0(x1)
    1e84:	00c5d733          	srl	x14,x11,x12
    1e88:	00c55533          	srl	x10,x10,x12
    1e8c:	00f595b3          	sll	x11,x11,x15
    1e90:	00b56533          	or	x10,x10,x11
    1e94:	fe9ff06f          	jal	x0,1e7c <__lshrdi3+0x1c>

00001e98 <__ashldi3>:
    1e98:	02060063          	beq	x12,x0,1eb8 <__ashldi3+0x20>
    1e9c:	02000793          	addi	x15,x0,32
    1ea0:	40c787b3          	sub	x15,x15,x12
    1ea4:	00f04c63          	blt	x0,x15,1ebc <__ashldi3+0x24>
    1ea8:	fe060613          	addi	x12,x12,-32
    1eac:	00c515b3          	sll	x11,x10,x12
    1eb0:	00000713          	addi	x14,x0,0
    1eb4:	00070513          	addi	x10,x14,0
    1eb8:	00008067          	jalr	x0,0(x1)
    1ebc:	00c51733          	sll	x14,x10,x12
    1ec0:	00c595b3          	sll	x11,x11,x12
    1ec4:	00f55533          	srl	x10,x10,x15
    1ec8:	00a5e5b3          	or	x11,x11,x10
    1ecc:	fe9ff06f          	jal	x0,1eb4 <__ashldi3+0x1c>

00001ed0 <__divdi3>:
    1ed0:	fc010113          	addi	x2,x2,-64
    1ed4:	02912a23          	sw	x9,52(x2)
    1ed8:	03412423          	sw	x20,40(x2)
    1edc:	02112e23          	sw	x1,60(x2)
    1ee0:	02812c23          	sw	x8,56(x2)
    1ee4:	03212823          	sw	x18,48(x2)
    1ee8:	03312623          	sw	x19,44(x2)
    1eec:	03512223          	sw	x21,36(x2)
    1ef0:	03612023          	sw	x22,32(x2)
    1ef4:	01712e23          	sw	x23,28(x2)
    1ef8:	01812c23          	sw	x24,24(x2)
    1efc:	01912a23          	sw	x25,20(x2)
    1f00:	01a12823          	sw	x26,16(x2)
    1f04:	01b12623          	sw	x27,12(x2)
    1f08:	00050a13          	addi	x20,x10,0
    1f0c:	00000493          	addi	x9,x0,0
    1f10:	0005dc63          	bge	x11,x0,1f28 <__divdi3+0x58>
    1f14:	00a037b3          	sltu	x15,x0,x10
    1f18:	40b005b3          	sub	x11,x0,x11
    1f1c:	40f585b3          	sub	x11,x11,x15
    1f20:	40a00a33          	sub	x20,x0,x10
    1f24:	fff00493          	addi	x9,x0,-1
    1f28:	0006dc63          	bge	x13,x0,1f40 <__divdi3+0x70>
    1f2c:	00c037b3          	sltu	x15,x0,x12
    1f30:	40d006b3          	sub	x13,x0,x13
    1f34:	fff4c493          	xori	x9,x9,-1
    1f38:	40f686b3          	sub	x13,x13,x15
    1f3c:	40c00633          	sub	x12,x0,x12
    1f40:	00060a93          	addi	x21,x12,0
    1f44:	000a0993          	addi	x19,x20,0
    1f48:	00058913          	addi	x18,x11,0
    1f4c:	3e069063          	bne	x13,x0,232c <__divdi3+0x45c>
    1f50:	00002697          	auipc	x13,0x2
    1f54:	c3068693          	addi	x13,x13,-976 # 3b80 <__clz_tab>
    1f58:	14c5f263          	bgeu	x11,x12,209c <__divdi3+0x1cc>
    1f5c:	000107b7          	lui	x15,0x10
    1f60:	12f67463          	bgeu	x12,x15,2088 <__divdi3+0x1b8>
    1f64:	10063793          	sltiu	x15,x12,256
    1f68:	0017b793          	sltiu	x15,x15,1
    1f6c:	00379793          	slli	x15,x15,0x3
    1f70:	00f65733          	srl	x14,x12,x15
    1f74:	00e686b3          	add	x13,x13,x14
    1f78:	0006c703          	lbu	x14,0(x13)
    1f7c:	02000693          	addi	x13,x0,32
    1f80:	00f707b3          	add	x15,x14,x15
    1f84:	40f68733          	sub	x14,x13,x15
    1f88:	00f68c63          	beq	x13,x15,1fa0 <__divdi3+0xd0>
    1f8c:	00e59933          	sll	x18,x11,x14
    1f90:	00fa57b3          	srl	x15,x20,x15
    1f94:	00e61ab3          	sll	x21,x12,x14
    1f98:	0127e933          	or	x18,x15,x18
    1f9c:	00ea19b3          	sll	x19,x20,x14
    1fa0:	010adb13          	srli	x22,x21,0x10
    1fa4:	000b0593          	addi	x11,x22,0
    1fa8:	00090513          	addi	x10,x18,0
    1fac:	010a9b93          	slli	x23,x21,0x10
    1fb0:	00001097          	auipc	x1,0x1
    1fb4:	738080e7          	jalr	x1,1848(x1) # 36e8 <__hidden___udivsi3>
    1fb8:	010bdb93          	srli	x23,x23,0x10
    1fbc:	00050593          	addi	x11,x10,0
    1fc0:	00050a13          	addi	x20,x10,0
    1fc4:	000b8513          	addi	x10,x23,0
    1fc8:	00001097          	auipc	x1,0x1
    1fcc:	660080e7          	jalr	x1,1632(x1) # 3628 <__mulsi3>
    1fd0:	00050413          	addi	x8,x10,0
    1fd4:	000b0593          	addi	x11,x22,0
    1fd8:	00090513          	addi	x10,x18,0
    1fdc:	00001097          	auipc	x1,0x1
    1fe0:	754080e7          	jalr	x1,1876(x1) # 3730 <__umodsi3>
    1fe4:	01051513          	slli	x10,x10,0x10
    1fe8:	0109d713          	srli	x14,x19,0x10
    1fec:	00a76733          	or	x14,x14,x10
    1ff0:	000a0913          	addi	x18,x20,0
    1ff4:	00877e63          	bgeu	x14,x8,2010 <__divdi3+0x140>
    1ff8:	00ea8733          	add	x14,x21,x14
    1ffc:	fffa0913          	addi	x18,x20,-1
    2000:	01576863          	bltu	x14,x21,2010 <__divdi3+0x140>
    2004:	00877663          	bgeu	x14,x8,2010 <__divdi3+0x140>
    2008:	ffea0913          	addi	x18,x20,-2
    200c:	01570733          	add	x14,x14,x21
    2010:	40870433          	sub	x8,x14,x8
    2014:	000b0593          	addi	x11,x22,0
    2018:	00040513          	addi	x10,x8,0
    201c:	00001097          	auipc	x1,0x1
    2020:	6cc080e7          	jalr	x1,1740(x1) # 36e8 <__hidden___udivsi3>
    2024:	00050593          	addi	x11,x10,0
    2028:	00050a13          	addi	x20,x10,0
    202c:	000b8513          	addi	x10,x23,0
    2030:	00001097          	auipc	x1,0x1
    2034:	5f8080e7          	jalr	x1,1528(x1) # 3628 <__mulsi3>
    2038:	00050b93          	addi	x23,x10,0
    203c:	000b0593          	addi	x11,x22,0
    2040:	00040513          	addi	x10,x8,0
    2044:	00001097          	auipc	x1,0x1
    2048:	6ec080e7          	jalr	x1,1772(x1) # 3730 <__umodsi3>
    204c:	01099993          	slli	x19,x19,0x10
    2050:	01051513          	slli	x10,x10,0x10
    2054:	0109d993          	srli	x19,x19,0x10
    2058:	00a9e9b3          	or	x19,x19,x10
    205c:	000a0713          	addi	x14,x20,0
    2060:	0179fc63          	bgeu	x19,x23,2078 <__divdi3+0x1a8>
    2064:	013a89b3          	add	x19,x21,x19
    2068:	fffa0713          	addi	x14,x20,-1
    206c:	0159e663          	bltu	x19,x21,2078 <__divdi3+0x1a8>
    2070:	0179f463          	bgeu	x19,x23,2078 <__divdi3+0x1a8>
    2074:	ffea0713          	addi	x14,x20,-2
    2078:	01091793          	slli	x15,x18,0x10
    207c:	00e7e7b3          	or	x15,x15,x14
    2080:	00000913          	addi	x18,x0,0
    2084:	1380006f          	jal	x0,21bc <__divdi3+0x2ec>
    2088:	01000737          	lui	x14,0x1000
    208c:	01800793          	addi	x15,x0,24
    2090:	eee670e3          	bgeu	x12,x14,1f70 <__divdi3+0xa0>
    2094:	01000793          	addi	x15,x0,16
    2098:	ed9ff06f          	jal	x0,1f70 <__divdi3+0xa0>
    209c:	00000713          	addi	x14,x0,0
    20a0:	00060c63          	beq	x12,x0,20b8 <__divdi3+0x1e8>
    20a4:	000107b7          	lui	x15,0x10
    20a8:	16f67663          	bgeu	x12,x15,2214 <__divdi3+0x344>
    20ac:	10063713          	sltiu	x14,x12,256
    20b0:	00173713          	sltiu	x14,x14,1
    20b4:	00371713          	slli	x14,x14,0x3
    20b8:	00e657b3          	srl	x15,x12,x14
    20bc:	00f686b3          	add	x13,x13,x15
    20c0:	0006c783          	lbu	x15,0(x13)
    20c4:	02000693          	addi	x13,x0,32
    20c8:	00e787b3          	add	x15,x15,x14
    20cc:	40f68733          	sub	x14,x13,x15
    20d0:	14f69c63          	bne	x13,x15,2228 <__divdi3+0x358>
    20d4:	40c58a33          	sub	x20,x11,x12
    20d8:	00100913          	addi	x18,x0,1
    20dc:	010adb13          	srli	x22,x21,0x10
    20e0:	000b0593          	addi	x11,x22,0
    20e4:	000a0513          	addi	x10,x20,0
    20e8:	010a9b93          	slli	x23,x21,0x10
    20ec:	00001097          	auipc	x1,0x1
    20f0:	5fc080e7          	jalr	x1,1532(x1) # 36e8 <__hidden___udivsi3>
    20f4:	010bdb93          	srli	x23,x23,0x10
    20f8:	00050593          	addi	x11,x10,0
    20fc:	00050c93          	addi	x25,x10,0
    2100:	000b8513          	addi	x10,x23,0
    2104:	00001097          	auipc	x1,0x1
    2108:	524080e7          	jalr	x1,1316(x1) # 3628 <__mulsi3>
    210c:	00050c13          	addi	x24,x10,0
    2110:	000b0593          	addi	x11,x22,0
    2114:	000a0513          	addi	x10,x20,0
    2118:	00001097          	auipc	x1,0x1
    211c:	618080e7          	jalr	x1,1560(x1) # 3730 <__umodsi3>
    2120:	01051513          	slli	x10,x10,0x10
    2124:	0109d713          	srli	x14,x19,0x10
    2128:	00a76733          	or	x14,x14,x10
    212c:	000c8a13          	addi	x20,x25,0
    2130:	01877e63          	bgeu	x14,x24,214c <__divdi3+0x27c>
    2134:	00ea8733          	add	x14,x21,x14
    2138:	fffc8a13          	addi	x20,x25,-1
    213c:	01576863          	bltu	x14,x21,214c <__divdi3+0x27c>
    2140:	01877663          	bgeu	x14,x24,214c <__divdi3+0x27c>
    2144:	ffec8a13          	addi	x20,x25,-2
    2148:	01570733          	add	x14,x14,x21
    214c:	41870433          	sub	x8,x14,x24
    2150:	000b0593          	addi	x11,x22,0
    2154:	00040513          	addi	x10,x8,0
    2158:	00001097          	auipc	x1,0x1
    215c:	590080e7          	jalr	x1,1424(x1) # 36e8 <__hidden___udivsi3>
    2160:	00050593          	addi	x11,x10,0
    2164:	00050c13          	addi	x24,x10,0
    2168:	000b8513          	addi	x10,x23,0
    216c:	00001097          	auipc	x1,0x1
    2170:	4bc080e7          	jalr	x1,1212(x1) # 3628 <__mulsi3>
    2174:	00050b93          	addi	x23,x10,0
    2178:	000b0593          	addi	x11,x22,0
    217c:	00040513          	addi	x10,x8,0
    2180:	00001097          	auipc	x1,0x1
    2184:	5b0080e7          	jalr	x1,1456(x1) # 3730 <__umodsi3>
    2188:	01099993          	slli	x19,x19,0x10
    218c:	01051513          	slli	x10,x10,0x10
    2190:	0109d993          	srli	x19,x19,0x10
    2194:	00a9e9b3          	or	x19,x19,x10
    2198:	000c0713          	addi	x14,x24,0
    219c:	0179fc63          	bgeu	x19,x23,21b4 <__divdi3+0x2e4>
    21a0:	013a89b3          	add	x19,x21,x19
    21a4:	fffc0713          	addi	x14,x24,-1
    21a8:	0159e663          	bltu	x19,x21,21b4 <__divdi3+0x2e4>
    21ac:	0179f463          	bgeu	x19,x23,21b4 <__divdi3+0x2e4>
    21b0:	ffec0713          	addi	x14,x24,-2
    21b4:	010a1793          	slli	x15,x20,0x10
    21b8:	00e7e7b3          	or	x15,x15,x14
    21bc:	00078513          	addi	x10,x15,0 # 10000 <_stack_ptr>
    21c0:	00090593          	addi	x11,x18,0
    21c4:	00048a63          	beq	x9,x0,21d8 <__divdi3+0x308>
    21c8:	00f037b3          	sltu	x15,x0,x15
    21cc:	412005b3          	sub	x11,x0,x18
    21d0:	40f585b3          	sub	x11,x11,x15
    21d4:	40a00533          	sub	x10,x0,x10
    21d8:	03c12083          	lw	x1,60(x2)
    21dc:	03812403          	lw	x8,56(x2)
    21e0:	03412483          	lw	x9,52(x2)
    21e4:	03012903          	lw	x18,48(x2)
    21e8:	02c12983          	lw	x19,44(x2)
    21ec:	02812a03          	lw	x20,40(x2)
    21f0:	02412a83          	lw	x21,36(x2)
    21f4:	02012b03          	lw	x22,32(x2)
    21f8:	01c12b83          	lw	x23,28(x2)
    21fc:	01812c03          	lw	x24,24(x2)
    2200:	01412c83          	lw	x25,20(x2)
    2204:	01012d03          	lw	x26,16(x2)
    2208:	00c12d83          	lw	x27,12(x2)
    220c:	04010113          	addi	x2,x2,64
    2210:	00008067          	jalr	x0,0(x1)
    2214:	010007b7          	lui	x15,0x1000
    2218:	01800713          	addi	x14,x0,24
    221c:	e8f67ee3          	bgeu	x12,x15,20b8 <__divdi3+0x1e8>
    2220:	01000713          	addi	x14,x0,16
    2224:	e95ff06f          	jal	x0,20b8 <__divdi3+0x1e8>
    2228:	00e61ab3          	sll	x21,x12,x14
    222c:	00f5d933          	srl	x18,x11,x15
    2230:	010adb93          	srli	x23,x21,0x10
    2234:	00e595b3          	sll	x11,x11,x14
    2238:	00fa57b3          	srl	x15,x20,x15
    223c:	00b7eb33          	or	x22,x15,x11
    2240:	00ea19b3          	sll	x19,x20,x14
    2244:	000b8593          	addi	x11,x23,0
    2248:	00090513          	addi	x10,x18,0
    224c:	010a9a13          	slli	x20,x21,0x10
    2250:	00001097          	auipc	x1,0x1
    2254:	498080e7          	jalr	x1,1176(x1) # 36e8 <__hidden___udivsi3>
    2258:	010a5a13          	srli	x20,x20,0x10
    225c:	00050593          	addi	x11,x10,0
    2260:	00050c13          	addi	x24,x10,0
    2264:	000a0513          	addi	x10,x20,0
    2268:	00001097          	auipc	x1,0x1
    226c:	3c0080e7          	jalr	x1,960(x1) # 3628 <__mulsi3>
    2270:	00050413          	addi	x8,x10,0
    2274:	000b8593          	addi	x11,x23,0
    2278:	00090513          	addi	x10,x18,0
    227c:	00001097          	auipc	x1,0x1
    2280:	4b4080e7          	jalr	x1,1204(x1) # 3730 <__umodsi3>
    2284:	01051513          	slli	x10,x10,0x10
    2288:	010b5713          	srli	x14,x22,0x10
    228c:	00a76733          	or	x14,x14,x10
    2290:	000c0913          	addi	x18,x24,0
    2294:	00877e63          	bgeu	x14,x8,22b0 <__divdi3+0x3e0>
    2298:	00ea8733          	add	x14,x21,x14
    229c:	fffc0913          	addi	x18,x24,-1
    22a0:	01576863          	bltu	x14,x21,22b0 <__divdi3+0x3e0>
    22a4:	00877663          	bgeu	x14,x8,22b0 <__divdi3+0x3e0>
    22a8:	ffec0913          	addi	x18,x24,-2
    22ac:	01570733          	add	x14,x14,x21
    22b0:	40870433          	sub	x8,x14,x8
    22b4:	000b8593          	addi	x11,x23,0
    22b8:	00040513          	addi	x10,x8,0
    22bc:	00001097          	auipc	x1,0x1
    22c0:	42c080e7          	jalr	x1,1068(x1) # 36e8 <__hidden___udivsi3>
    22c4:	00050593          	addi	x11,x10,0
    22c8:	00050c13          	addi	x24,x10,0
    22cc:	000a0513          	addi	x10,x20,0
    22d0:	00001097          	auipc	x1,0x1
    22d4:	358080e7          	jalr	x1,856(x1) # 3628 <__mulsi3>
    22d8:	00050a13          	addi	x20,x10,0
    22dc:	000b8593          	addi	x11,x23,0
    22e0:	00040513          	addi	x10,x8,0
    22e4:	00001097          	auipc	x1,0x1
    22e8:	44c080e7          	jalr	x1,1100(x1) # 3730 <__umodsi3>
    22ec:	010b1793          	slli	x15,x22,0x10
    22f0:	01051513          	slli	x10,x10,0x10
    22f4:	0107d793          	srli	x15,x15,0x10
    22f8:	00a7e7b3          	or	x15,x15,x10
    22fc:	000c0713          	addi	x14,x24,0
    2300:	0147fe63          	bgeu	x15,x20,231c <__divdi3+0x44c>
    2304:	00fa87b3          	add	x15,x21,x15
    2308:	fffc0713          	addi	x14,x24,-1
    230c:	0157e863          	bltu	x15,x21,231c <__divdi3+0x44c>
    2310:	0147f663          	bgeu	x15,x20,231c <__divdi3+0x44c>
    2314:	ffec0713          	addi	x14,x24,-2
    2318:	015787b3          	add	x15,x15,x21
    231c:	01091913          	slli	x18,x18,0x10
    2320:	41478a33          	sub	x20,x15,x20
    2324:	00e96933          	or	x18,x18,x14
    2328:	db5ff06f          	jal	x0,20dc <__divdi3+0x20c>
    232c:	22d5e263          	bltu	x11,x13,2550 <__divdi3+0x680>
    2330:	000107b7          	lui	x15,0x10
    2334:	04f6f463          	bgeu	x13,x15,237c <__divdi3+0x4ac>
    2338:	1006b713          	sltiu	x14,x13,256
    233c:	00173713          	sltiu	x14,x14,1
    2340:	00371713          	slli	x14,x14,0x3
    2344:	00e6d533          	srl	x10,x13,x14
    2348:	00002797          	auipc	x15,0x2
    234c:	83878793          	addi	x15,x15,-1992 # 3b80 <__clz_tab>
    2350:	00a787b3          	add	x15,x15,x10
    2354:	0007c803          	lbu	x16,0(x15)
    2358:	02000793          	addi	x15,x0,32
    235c:	00e80833          	add	x16,x16,x14
    2360:	41078933          	sub	x18,x15,x16
    2364:	03079663          	bne	x15,x16,2390 <__divdi3+0x4c0>
    2368:	00100793          	addi	x15,x0,1
    236c:	e4b6e8e3          	bltu	x13,x11,21bc <__divdi3+0x2ec>
    2370:	00ca37b3          	sltu	x15,x20,x12
    2374:	0017b793          	sltiu	x15,x15,1
    2378:	e45ff06f          	jal	x0,21bc <__divdi3+0x2ec>
    237c:	010007b7          	lui	x15,0x1000
    2380:	01800713          	addi	x14,x0,24
    2384:	fcf6f0e3          	bgeu	x13,x15,2344 <__divdi3+0x474>
    2388:	01000713          	addi	x14,x0,16
    238c:	fb9ff06f          	jal	x0,2344 <__divdi3+0x474>
    2390:	012696b3          	sll	x13,x13,x18
    2394:	01065c33          	srl	x24,x12,x16
    2398:	00dc6c33          	or	x24,x24,x13
    239c:	0105dab3          	srl	x21,x11,x16
    23a0:	010a5733          	srl	x14,x20,x16
    23a4:	012595b3          	sll	x11,x11,x18
    23a8:	010c5b13          	srli	x22,x24,0x10
    23ac:	00b769b3          	or	x19,x14,x11
    23b0:	010c1b93          	slli	x23,x24,0x10
    23b4:	000b0593          	addi	x11,x22,0
    23b8:	000a8513          	addi	x10,x21,0
    23bc:	01261433          	sll	x8,x12,x18
    23c0:	010bdb93          	srli	x23,x23,0x10
    23c4:	00001097          	auipc	x1,0x1
    23c8:	324080e7          	jalr	x1,804(x1) # 36e8 <__hidden___udivsi3>
    23cc:	00050593          	addi	x11,x10,0
    23d0:	00050d93          	addi	x27,x10,0
    23d4:	000b8513          	addi	x10,x23,0
    23d8:	00001097          	auipc	x1,0x1
    23dc:	250080e7          	jalr	x1,592(x1) # 3628 <__mulsi3>
    23e0:	00050d13          	addi	x26,x10,0
    23e4:	000b0593          	addi	x11,x22,0
    23e8:	000a8513          	addi	x10,x21,0
    23ec:	00001097          	auipc	x1,0x1
    23f0:	344080e7          	jalr	x1,836(x1) # 3730 <__umodsi3>
    23f4:	01051513          	slli	x10,x10,0x10
    23f8:	0109d693          	srli	x13,x19,0x10
    23fc:	00a6e6b3          	or	x13,x13,x10
    2400:	000d8c93          	addi	x25,x27,0
    2404:	01a6fe63          	bgeu	x13,x26,2420 <__divdi3+0x550>
    2408:	00dc06b3          	add	x13,x24,x13
    240c:	fffd8c93          	addi	x25,x27,-1
    2410:	0186e863          	bltu	x13,x24,2420 <__divdi3+0x550>
    2414:	01a6f663          	bgeu	x13,x26,2420 <__divdi3+0x550>
    2418:	ffed8c93          	addi	x25,x27,-2
    241c:	018686b3          	add	x13,x13,x24
    2420:	41a68ab3          	sub	x21,x13,x26
    2424:	000b0593          	addi	x11,x22,0
    2428:	000a8513          	addi	x10,x21,0
    242c:	00001097          	auipc	x1,0x1
    2430:	2bc080e7          	jalr	x1,700(x1) # 36e8 <__hidden___udivsi3>
    2434:	00050593          	addi	x11,x10,0
    2438:	00050d13          	addi	x26,x10,0
    243c:	000b8513          	addi	x10,x23,0
    2440:	00001097          	auipc	x1,0x1
    2444:	1e8080e7          	jalr	x1,488(x1) # 3628 <__mulsi3>
    2448:	00050b93          	addi	x23,x10,0
    244c:	000b0593          	addi	x11,x22,0
    2450:	000a8513          	addi	x10,x21,0
    2454:	00001097          	auipc	x1,0x1
    2458:	2dc080e7          	jalr	x1,732(x1) # 3730 <__umodsi3>
    245c:	01099713          	slli	x14,x19,0x10
    2460:	01051513          	slli	x10,x10,0x10
    2464:	01075713          	srli	x14,x14,0x10
    2468:	00a76733          	or	x14,x14,x10
    246c:	000d0693          	addi	x13,x26,0
    2470:	01777e63          	bgeu	x14,x23,248c <__divdi3+0x5bc>
    2474:	00ec0733          	add	x14,x24,x14
    2478:	fffd0693          	addi	x13,x26,-1
    247c:	01876863          	bltu	x14,x24,248c <__divdi3+0x5bc>
    2480:	01777663          	bgeu	x14,x23,248c <__divdi3+0x5bc>
    2484:	ffed0693          	addi	x13,x26,-2
    2488:	01870733          	add	x14,x14,x24
    248c:	010c9793          	slli	x15,x25,0x10
    2490:	00010e37          	lui	x28,0x10
    2494:	00d7e7b3          	or	x15,x15,x13
    2498:	fffe0313          	addi	x6,x28,-1 # ffff <_bss_end+0xa554>
    249c:	0067f8b3          	and	x17,x15,x6
    24a0:	00647333          	and	x6,x8,x6
    24a4:	41770733          	sub	x14,x14,x23
    24a8:	0107de93          	srli	x29,x15,0x10
    24ac:	01045413          	srli	x8,x8,0x10
    24b0:	00088513          	addi	x10,x17,0
    24b4:	00030593          	addi	x11,x6,0
    24b8:	00001097          	auipc	x1,0x1
    24bc:	170080e7          	jalr	x1,368(x1) # 3628 <__mulsi3>
    24c0:	00050813          	addi	x16,x10,0
    24c4:	00040593          	addi	x11,x8,0
    24c8:	00088513          	addi	x10,x17,0
    24cc:	00001097          	auipc	x1,0x1
    24d0:	15c080e7          	jalr	x1,348(x1) # 3628 <__mulsi3>
    24d4:	00050893          	addi	x17,x10,0
    24d8:	00030593          	addi	x11,x6,0
    24dc:	000e8513          	addi	x10,x29,0
    24e0:	00001097          	auipc	x1,0x1
    24e4:	148080e7          	jalr	x1,328(x1) # 3628 <__mulsi3>
    24e8:	00050313          	addi	x6,x10,0
    24ec:	00040593          	addi	x11,x8,0
    24f0:	000e8513          	addi	x10,x29,0
    24f4:	00001097          	auipc	x1,0x1
    24f8:	134080e7          	jalr	x1,308(x1) # 3628 <__mulsi3>
    24fc:	01085693          	srli	x13,x16,0x10
    2500:	006888b3          	add	x17,x17,x6
    2504:	011686b3          	add	x13,x13,x17
    2508:	00050613          	addi	x12,x10,0
    250c:	0066f463          	bgeu	x13,x6,2514 <__divdi3+0x644>
    2510:	01c50633          	add	x12,x10,x28
    2514:	0106d593          	srli	x11,x13,0x10
    2518:	00c58633          	add	x12,x11,x12
    251c:	02c76663          	bltu	x14,x12,2548 <__divdi3+0x678>
    2520:	b6c710e3          	bne	x14,x12,2080 <__divdi3+0x1b0>
    2524:	00010637          	lui	x12,0x10
    2528:	fff60613          	addi	x12,x12,-1 # ffff <_bss_end+0xa554>
    252c:	00c6f6b3          	and	x13,x13,x12
    2530:	01069693          	slli	x13,x13,0x10
    2534:	00c87833          	and	x16,x16,x12
    2538:	012a1733          	sll	x14,x20,x18
    253c:	01068533          	add	x10,x13,x16
    2540:	00000913          	addi	x18,x0,0
    2544:	c6a77ce3          	bgeu	x14,x10,21bc <__divdi3+0x2ec>
    2548:	fff78793          	addi	x15,x15,-1 # ffffff <_stack_ptr+0xfeffff>
    254c:	b35ff06f          	jal	x0,2080 <__divdi3+0x1b0>
    2550:	00000913          	addi	x18,x0,0
    2554:	00000793          	addi	x15,x0,0
    2558:	c65ff06f          	jal	x0,21bc <__divdi3+0x2ec>

0000255c <__moddi3>:
    255c:	fc010113          	addi	x2,x2,-64
    2560:	02912a23          	sw	x9,52(x2)
    2564:	02112e23          	sw	x1,60(x2)
    2568:	02812c23          	sw	x8,56(x2)
    256c:	03212823          	sw	x18,48(x2)
    2570:	03312623          	sw	x19,44(x2)
    2574:	03412423          	sw	x20,40(x2)
    2578:	03512223          	sw	x21,36(x2)
    257c:	03612023          	sw	x22,32(x2)
    2580:	01712e23          	sw	x23,28(x2)
    2584:	01812c23          	sw	x24,24(x2)
    2588:	01912a23          	sw	x25,20(x2)
    258c:	01a12823          	sw	x26,16(x2)
    2590:	01b12623          	sw	x27,12(x2)
    2594:	00000493          	addi	x9,x0,0
    2598:	0005dc63          	bge	x11,x0,25b0 <__moddi3+0x54>
    259c:	00a037b3          	sltu	x15,x0,x10
    25a0:	40b005b3          	sub	x11,x0,x11
    25a4:	40f585b3          	sub	x11,x11,x15
    25a8:	40a00533          	sub	x10,x0,x10
    25ac:	fff00493          	addi	x9,x0,-1
    25b0:	0006da63          	bge	x13,x0,25c4 <__moddi3+0x68>
    25b4:	00c037b3          	sltu	x15,x0,x12
    25b8:	40d006b3          	sub	x13,x0,x13
    25bc:	40f686b3          	sub	x13,x13,x15
    25c0:	40c00633          	sub	x12,x0,x12
    25c4:	00060a13          	addi	x20,x12,0
    25c8:	00050413          	addi	x8,x10,0
    25cc:	00058913          	addi	x18,x11,0
    25d0:	28069e63          	bne	x13,x0,286c <__moddi3+0x310>
    25d4:	00001697          	auipc	x13,0x1
    25d8:	5ac68693          	addi	x13,x13,1452 # 3b80 <__clz_tab>
    25dc:	16c5f663          	bgeu	x11,x12,2748 <__moddi3+0x1ec>
    25e0:	000107b7          	lui	x15,0x10
    25e4:	14f67863          	bgeu	x12,x15,2734 <__moddi3+0x1d8>
    25e8:	10063793          	sltiu	x15,x12,256
    25ec:	0017b793          	sltiu	x15,x15,1
    25f0:	00379793          	slli	x15,x15,0x3
    25f4:	00f65733          	srl	x14,x12,x15
    25f8:	00e686b3          	add	x13,x13,x14
    25fc:	0006c703          	lbu	x14,0(x13)
    2600:	00f707b3          	add	x15,x14,x15
    2604:	02000713          	addi	x14,x0,32
    2608:	40f709b3          	sub	x19,x14,x15
    260c:	00f70c63          	beq	x14,x15,2624 <__moddi3+0xc8>
    2610:	013595b3          	sll	x11,x11,x19
    2614:	00f557b3          	srl	x15,x10,x15
    2618:	01361a33          	sll	x20,x12,x19
    261c:	00b7e933          	or	x18,x15,x11
    2620:	01351433          	sll	x8,x10,x19
    2624:	010a5b13          	srli	x22,x20,0x10
    2628:	000b0593          	addi	x11,x22,0
    262c:	010a1b93          	slli	x23,x20,0x10
    2630:	00090513          	addi	x10,x18,0
    2634:	00001097          	auipc	x1,0x1
    2638:	0b4080e7          	jalr	x1,180(x1) # 36e8 <__hidden___udivsi3>
    263c:	010bdb93          	srli	x23,x23,0x10
    2640:	000b8593          	addi	x11,x23,0
    2644:	00001097          	auipc	x1,0x1
    2648:	fe4080e7          	jalr	x1,-28(x1) # 3628 <__mulsi3>
    264c:	00050a93          	addi	x21,x10,0
    2650:	000b0593          	addi	x11,x22,0
    2654:	00090513          	addi	x10,x18,0
    2658:	00001097          	auipc	x1,0x1
    265c:	0d8080e7          	jalr	x1,216(x1) # 3730 <__umodsi3>
    2660:	01051513          	slli	x10,x10,0x10
    2664:	01045793          	srli	x15,x8,0x10
    2668:	00a7e7b3          	or	x15,x15,x10
    266c:	0157fa63          	bgeu	x15,x21,2680 <__moddi3+0x124>
    2670:	00fa07b3          	add	x15,x20,x15
    2674:	0147e663          	bltu	x15,x20,2680 <__moddi3+0x124>
    2678:	0157f463          	bgeu	x15,x21,2680 <__moddi3+0x124>
    267c:	014787b3          	add	x15,x15,x20
    2680:	41578933          	sub	x18,x15,x21
    2684:	000b0593          	addi	x11,x22,0
    2688:	00090513          	addi	x10,x18,0
    268c:	00001097          	auipc	x1,0x1
    2690:	05c080e7          	jalr	x1,92(x1) # 36e8 <__hidden___udivsi3>
    2694:	000b8593          	addi	x11,x23,0
    2698:	00001097          	auipc	x1,0x1
    269c:	f90080e7          	jalr	x1,-112(x1) # 3628 <__mulsi3>
    26a0:	00050a93          	addi	x21,x10,0
    26a4:	000b0593          	addi	x11,x22,0
    26a8:	00090513          	addi	x10,x18,0
    26ac:	00001097          	auipc	x1,0x1
    26b0:	084080e7          	jalr	x1,132(x1) # 3730 <__umodsi3>
    26b4:	01041413          	slli	x8,x8,0x10
    26b8:	01051513          	slli	x10,x10,0x10
    26bc:	01045413          	srli	x8,x8,0x10
    26c0:	00a46433          	or	x8,x8,x10
    26c4:	01547a63          	bgeu	x8,x21,26d8 <__moddi3+0x17c>
    26c8:	008a0433          	add	x8,x20,x8
    26cc:	01446663          	bltu	x8,x20,26d8 <__moddi3+0x17c>
    26d0:	01547463          	bgeu	x8,x21,26d8 <__moddi3+0x17c>
    26d4:	01440433          	add	x8,x8,x20
    26d8:	41540433          	sub	x8,x8,x21
    26dc:	01345533          	srl	x10,x8,x19
    26e0:	00000593          	addi	x11,x0,0
    26e4:	00048a63          	beq	x9,x0,26f8 <__moddi3+0x19c>
    26e8:	00a037b3          	sltu	x15,x0,x10
    26ec:	40b005b3          	sub	x11,x0,x11
    26f0:	40f585b3          	sub	x11,x11,x15
    26f4:	40a00533          	sub	x10,x0,x10
    26f8:	03c12083          	lw	x1,60(x2)
    26fc:	03812403          	lw	x8,56(x2)
    2700:	03412483          	lw	x9,52(x2)
    2704:	03012903          	lw	x18,48(x2)
    2708:	02c12983          	lw	x19,44(x2)
    270c:	02812a03          	lw	x20,40(x2)
    2710:	02412a83          	lw	x21,36(x2)
    2714:	02012b03          	lw	x22,32(x2)
    2718:	01c12b83          	lw	x23,28(x2)
    271c:	01812c03          	lw	x24,24(x2)
    2720:	01412c83          	lw	x25,20(x2)
    2724:	01012d03          	lw	x26,16(x2)
    2728:	00c12d83          	lw	x27,12(x2)
    272c:	04010113          	addi	x2,x2,64
    2730:	00008067          	jalr	x0,0(x1)
    2734:	01000737          	lui	x14,0x1000
    2738:	01800793          	addi	x15,x0,24
    273c:	eae67ce3          	bgeu	x12,x14,25f4 <__moddi3+0x98>
    2740:	01000793          	addi	x15,x0,16
    2744:	eb1ff06f          	jal	x0,25f4 <__moddi3+0x98>
    2748:	00000713          	addi	x14,x0,0
    274c:	00060c63          	beq	x12,x0,2764 <__moddi3+0x208>
    2750:	000107b7          	lui	x15,0x10
    2754:	10f67263          	bgeu	x12,x15,2858 <__moddi3+0x2fc>
    2758:	10063713          	sltiu	x14,x12,256
    275c:	00173713          	sltiu	x14,x14,1
    2760:	00371713          	slli	x14,x14,0x3
    2764:	00e657b3          	srl	x15,x12,x14
    2768:	00f686b3          	add	x13,x13,x15
    276c:	0006c783          	lbu	x15,0(x13)
    2770:	40c58933          	sub	x18,x11,x12
    2774:	00e787b3          	add	x15,x15,x14
    2778:	02000713          	addi	x14,x0,32
    277c:	40f709b3          	sub	x19,x14,x15
    2780:	eaf702e3          	beq	x14,x15,2624 <__moddi3+0xc8>
    2784:	01361a33          	sll	x20,x12,x19
    2788:	00f5d933          	srl	x18,x11,x15
    278c:	010a5b93          	srli	x23,x20,0x10
    2790:	00f557b3          	srl	x15,x10,x15
    2794:	013595b3          	sll	x11,x11,x19
    2798:	00b7eab3          	or	x21,x15,x11
    279c:	01351433          	sll	x8,x10,x19
    27a0:	000b8593          	addi	x11,x23,0
    27a4:	010a1b13          	slli	x22,x20,0x10
    27a8:	00090513          	addi	x10,x18,0
    27ac:	00001097          	auipc	x1,0x1
    27b0:	f3c080e7          	jalr	x1,-196(x1) # 36e8 <__hidden___udivsi3>
    27b4:	010b5b13          	srli	x22,x22,0x10
    27b8:	000b0593          	addi	x11,x22,0
    27bc:	00001097          	auipc	x1,0x1
    27c0:	e6c080e7          	jalr	x1,-404(x1) # 3628 <__mulsi3>
    27c4:	00050c13          	addi	x24,x10,0
    27c8:	000b8593          	addi	x11,x23,0
    27cc:	00090513          	addi	x10,x18,0
    27d0:	00001097          	auipc	x1,0x1
    27d4:	f60080e7          	jalr	x1,-160(x1) # 3730 <__umodsi3>
    27d8:	01051513          	slli	x10,x10,0x10
    27dc:	010ad713          	srli	x14,x21,0x10
    27e0:	00a76733          	or	x14,x14,x10
    27e4:	01877a63          	bgeu	x14,x24,27f8 <__moddi3+0x29c>
    27e8:	00ea0733          	add	x14,x20,x14
    27ec:	01476663          	bltu	x14,x20,27f8 <__moddi3+0x29c>
    27f0:	01877463          	bgeu	x14,x24,27f8 <__moddi3+0x29c>
    27f4:	01470733          	add	x14,x14,x20
    27f8:	41870c33          	sub	x24,x14,x24
    27fc:	000b8593          	addi	x11,x23,0
    2800:	000c0513          	addi	x10,x24,0
    2804:	00001097          	auipc	x1,0x1
    2808:	ee4080e7          	jalr	x1,-284(x1) # 36e8 <__hidden___udivsi3>
    280c:	000b0593          	addi	x11,x22,0
    2810:	00001097          	auipc	x1,0x1
    2814:	e18080e7          	jalr	x1,-488(x1) # 3628 <__mulsi3>
    2818:	00050b13          	addi	x22,x10,0
    281c:	000b8593          	addi	x11,x23,0
    2820:	000c0513          	addi	x10,x24,0
    2824:	00001097          	auipc	x1,0x1
    2828:	f0c080e7          	jalr	x1,-244(x1) # 3730 <__umodsi3>
    282c:	010a9793          	slli	x15,x21,0x10
    2830:	01051513          	slli	x10,x10,0x10
    2834:	0107d793          	srli	x15,x15,0x10
    2838:	00a7e7b3          	or	x15,x15,x10
    283c:	0167fa63          	bgeu	x15,x22,2850 <__moddi3+0x2f4>
    2840:	00fa07b3          	add	x15,x20,x15
    2844:	0147e663          	bltu	x15,x20,2850 <__moddi3+0x2f4>
    2848:	0167f463          	bgeu	x15,x22,2850 <__moddi3+0x2f4>
    284c:	014787b3          	add	x15,x15,x20
    2850:	41678933          	sub	x18,x15,x22
    2854:	dd1ff06f          	jal	x0,2624 <__moddi3+0xc8>
    2858:	010007b7          	lui	x15,0x1000
    285c:	01800713          	addi	x14,x0,24
    2860:	f0f672e3          	bgeu	x12,x15,2764 <__moddi3+0x208>
    2864:	01000713          	addi	x14,x0,16
    2868:	efdff06f          	jal	x0,2764 <__moddi3+0x208>
    286c:	e6d5ece3          	bltu	x11,x13,26e4 <__moddi3+0x188>
    2870:	000107b7          	lui	x15,0x10
    2874:	04f6fe63          	bgeu	x13,x15,28d0 <__moddi3+0x374>
    2878:	1006b793          	sltiu	x15,x13,256
    287c:	0017b793          	sltiu	x15,x15,1
    2880:	00379793          	slli	x15,x15,0x3
    2884:	00f6d833          	srl	x16,x13,x15
    2888:	00001717          	auipc	x14,0x1
    288c:	2f870713          	addi	x14,x14,760 # 3b80 <__clz_tab>
    2890:	01070733          	add	x14,x14,x16
    2894:	00074a03          	lbu	x20,0(x14)
    2898:	00fa0a33          	add	x20,x20,x15
    289c:	02000793          	addi	x15,x0,32
    28a0:	414789b3          	sub	x19,x15,x20
    28a4:	05479063          	bne	x15,x20,28e4 <__moddi3+0x388>
    28a8:	00b6e463          	bltu	x13,x11,28b0 <__moddi3+0x354>
    28ac:	00c56c63          	bltu	x10,x12,28c4 <__moddi3+0x368>
    28b0:	40c50ab3          	sub	x21,x10,x12
    28b4:	40d586b3          	sub	x13,x11,x13
    28b8:	015535b3          	sltu	x11,x10,x21
    28bc:	000a8413          	addi	x8,x21,0
    28c0:	40b68933          	sub	x18,x13,x11
    28c4:	00040513          	addi	x10,x8,0
    28c8:	00090593          	addi	x11,x18,0
    28cc:	e19ff06f          	jal	x0,26e4 <__moddi3+0x188>
    28d0:	01000737          	lui	x14,0x1000
    28d4:	01800793          	addi	x15,x0,24
    28d8:	fae6f6e3          	bgeu	x13,x14,2884 <__moddi3+0x328>
    28dc:	01000793          	addi	x15,x0,16
    28e0:	fa5ff06f          	jal	x0,2884 <__moddi3+0x328>
    28e4:	013696b3          	sll	x13,x13,x19
    28e8:	01465bb3          	srl	x23,x12,x20
    28ec:	00dbebb3          	or	x23,x23,x13
    28f0:	0145db33          	srl	x22,x11,x20
    28f4:	01455433          	srl	x8,x10,x20
    28f8:	013595b3          	sll	x11,x11,x19
    28fc:	010bdc13          	srli	x24,x23,0x10
    2900:	00b46433          	or	x8,x8,x11
    2904:	01351933          	sll	x18,x10,x19
    2908:	000c0593          	addi	x11,x24,0
    290c:	000b0513          	addi	x10,x22,0
    2910:	010b9c93          	slli	x25,x23,0x10
    2914:	01361ab3          	sll	x21,x12,x19
    2918:	010cdc93          	srli	x25,x25,0x10
    291c:	00001097          	auipc	x1,0x1
    2920:	dcc080e7          	jalr	x1,-564(x1) # 36e8 <__hidden___udivsi3>
    2924:	00050593          	addi	x11,x10,0
    2928:	00050d93          	addi	x27,x10,0
    292c:	000c8513          	addi	x10,x25,0
    2930:	00001097          	auipc	x1,0x1
    2934:	cf8080e7          	jalr	x1,-776(x1) # 3628 <__mulsi3>
    2938:	00050d13          	addi	x26,x10,0
    293c:	000c0593          	addi	x11,x24,0
    2940:	000b0513          	addi	x10,x22,0
    2944:	00001097          	auipc	x1,0x1
    2948:	dec080e7          	jalr	x1,-532(x1) # 3730 <__umodsi3>
    294c:	01051513          	slli	x10,x10,0x10
    2950:	01045793          	srli	x15,x8,0x10
    2954:	00a7e7b3          	or	x15,x15,x10
    2958:	000d8b13          	addi	x22,x27,0
    295c:	01a7fe63          	bgeu	x15,x26,2978 <__moddi3+0x41c>
    2960:	00fb87b3          	add	x15,x23,x15
    2964:	fffd8b13          	addi	x22,x27,-1
    2968:	0177e863          	bltu	x15,x23,2978 <__moddi3+0x41c>
    296c:	01a7f663          	bgeu	x15,x26,2978 <__moddi3+0x41c>
    2970:	ffed8b13          	addi	x22,x27,-2
    2974:	017787b3          	add	x15,x15,x23
    2978:	41a78d33          	sub	x26,x15,x26
    297c:	000c0593          	addi	x11,x24,0
    2980:	000d0513          	addi	x10,x26,0
    2984:	00001097          	auipc	x1,0x1
    2988:	d64080e7          	jalr	x1,-668(x1) # 36e8 <__hidden___udivsi3>
    298c:	00050593          	addi	x11,x10,0
    2990:	00050d93          	addi	x27,x10,0
    2994:	000c8513          	addi	x10,x25,0
    2998:	00001097          	auipc	x1,0x1
    299c:	c90080e7          	jalr	x1,-880(x1) # 3628 <__mulsi3>
    29a0:	000c0593          	addi	x11,x24,0
    29a4:	00050c93          	addi	x25,x10,0
    29a8:	000d0513          	addi	x10,x26,0
    29ac:	00001097          	auipc	x1,0x1
    29b0:	d84080e7          	jalr	x1,-636(x1) # 3730 <__umodsi3>
    29b4:	01041593          	slli	x11,x8,0x10
    29b8:	01051513          	slli	x10,x10,0x10
    29bc:	0105d593          	srli	x11,x11,0x10
    29c0:	00a5e5b3          	or	x11,x11,x10
    29c4:	000d8713          	addi	x14,x27,0
    29c8:	0195fe63          	bgeu	x11,x25,29e4 <__moddi3+0x488>
    29cc:	00bb85b3          	add	x11,x23,x11
    29d0:	fffd8713          	addi	x14,x27,-1
    29d4:	0175e863          	bltu	x11,x23,29e4 <__moddi3+0x488>
    29d8:	0195f663          	bgeu	x11,x25,29e4 <__moddi3+0x488>
    29dc:	ffed8713          	addi	x14,x27,-2
    29e0:	017585b3          	add	x11,x11,x23
    29e4:	00010337          	lui	x6,0x10
    29e8:	010b1b13          	slli	x22,x22,0x10
    29ec:	00eb6b33          	or	x22,x22,x14
    29f0:	fff30713          	addi	x14,x6,-1 # ffff <_bss_end+0xa554>
    29f4:	00eb7e33          	and	x28,x22,x14
    29f8:	00eaf733          	and	x14,x21,x14
    29fc:	419587b3          	sub	x15,x11,x25
    2a00:	010b5b13          	srli	x22,x22,0x10
    2a04:	010ad893          	srli	x17,x21,0x10
    2a08:	000e0513          	addi	x10,x28,0
    2a0c:	00070593          	addi	x11,x14,0 # 1000000 <_stack_ptr+0xff0000>
    2a10:	00001097          	auipc	x1,0x1
    2a14:	c18080e7          	jalr	x1,-1000(x1) # 3628 <__mulsi3>
    2a18:	00050813          	addi	x16,x10,0
    2a1c:	00088593          	addi	x11,x17,0
    2a20:	000e0513          	addi	x10,x28,0
    2a24:	00001097          	auipc	x1,0x1
    2a28:	c04080e7          	jalr	x1,-1020(x1) # 3628 <__mulsi3>
    2a2c:	00050413          	addi	x8,x10,0
    2a30:	00070593          	addi	x11,x14,0
    2a34:	000b0513          	addi	x10,x22,0
    2a38:	00001097          	auipc	x1,0x1
    2a3c:	bf0080e7          	jalr	x1,-1040(x1) # 3628 <__mulsi3>
    2a40:	00050713          	addi	x14,x10,0
    2a44:	00088593          	addi	x11,x17,0
    2a48:	000b0513          	addi	x10,x22,0
    2a4c:	00001097          	auipc	x1,0x1
    2a50:	bdc080e7          	jalr	x1,-1060(x1) # 3628 <__mulsi3>
    2a54:	00e40433          	add	x8,x8,x14
    2a58:	01085693          	srli	x13,x16,0x10
    2a5c:	00d40433          	add	x8,x8,x13
    2a60:	00e47463          	bgeu	x8,x14,2a68 <__moddi3+0x50c>
    2a64:	00650533          	add	x10,x10,x6
    2a68:	000106b7          	lui	x13,0x10
    2a6c:	fff68693          	addi	x13,x13,-1 # ffff <_bss_end+0xa554>
    2a70:	01045713          	srli	x14,x8,0x10
    2a74:	00d47433          	and	x8,x8,x13
    2a78:	01041413          	slli	x8,x8,0x10
    2a7c:	00d87833          	and	x16,x16,x13
    2a80:	00a70733          	add	x14,x14,x10
    2a84:	01040433          	add	x8,x8,x16
    2a88:	00e7e663          	bltu	x15,x14,2a94 <__moddi3+0x538>
    2a8c:	00e79e63          	bne	x15,x14,2aa8 <__moddi3+0x54c>
    2a90:	00897c63          	bgeu	x18,x8,2aa8 <__moddi3+0x54c>
    2a94:	41540ab3          	sub	x21,x8,x21
    2a98:	015436b3          	sltu	x13,x8,x21
    2a9c:	017686b3          	add	x13,x13,x23
    2aa0:	000a8413          	addi	x8,x21,0
    2aa4:	40d70733          	sub	x14,x14,x13
    2aa8:	40890433          	sub	x8,x18,x8
    2aac:	00893933          	sltu	x18,x18,x8
    2ab0:	40e785b3          	sub	x11,x15,x14
    2ab4:	412585b3          	sub	x11,x11,x18
    2ab8:	01459a33          	sll	x20,x11,x20
    2abc:	01345433          	srl	x8,x8,x19
    2ac0:	008a6533          	or	x10,x20,x8
    2ac4:	0135d5b3          	srl	x11,x11,x19
    2ac8:	c1dff06f          	jal	x0,26e4 <__moddi3+0x188>

00002acc <__udivdi3>:
    2acc:	fd010113          	addi	x2,x2,-48
    2ad0:	01412c23          	sw	x20,24(x2)
    2ad4:	02112623          	sw	x1,44(x2)
    2ad8:	02812423          	sw	x8,40(x2)
    2adc:	02912223          	sw	x9,36(x2)
    2ae0:	03212023          	sw	x18,32(x2)
    2ae4:	01312e23          	sw	x19,28(x2)
    2ae8:	01512a23          	sw	x21,20(x2)
    2aec:	01612823          	sw	x22,16(x2)
    2af0:	01712623          	sw	x23,12(x2)
    2af4:	01812423          	sw	x24,8(x2)
    2af8:	01912223          	sw	x25,4(x2)
    2afc:	00050a13          	addi	x20,x10,0
    2b00:	3c069863          	bne	x13,x0,2ed0 <__udivdi3+0x404>
    2b04:	00060993          	addi	x19,x12,0
    2b08:	00050493          	addi	x9,x10,0
    2b0c:	00001797          	auipc	x15,0x1
    2b10:	07478793          	addi	x15,x15,116 # 3b80 <__clz_tab>
    2b14:	14c5f463          	bgeu	x11,x12,2c5c <__udivdi3+0x190>
    2b18:	00010737          	lui	x14,0x10
    2b1c:	00058913          	addi	x18,x11,0
    2b20:	12e67463          	bgeu	x12,x14,2c48 <__udivdi3+0x17c>
    2b24:	10063713          	sltiu	x14,x12,256
    2b28:	00173713          	sltiu	x14,x14,1
    2b2c:	00371713          	slli	x14,x14,0x3
    2b30:	00e656b3          	srl	x13,x12,x14
    2b34:	00d787b3          	add	x15,x15,x13
    2b38:	0007c683          	lbu	x13,0(x15)
    2b3c:	00e68733          	add	x14,x13,x14
    2b40:	02000693          	addi	x13,x0,32
    2b44:	40e687b3          	sub	x15,x13,x14
    2b48:	00e68c63          	beq	x13,x14,2b60 <__udivdi3+0x94>
    2b4c:	00f59933          	sll	x18,x11,x15
    2b50:	00ea5733          	srl	x14,x20,x14
    2b54:	00f619b3          	sll	x19,x12,x15
    2b58:	01276933          	or	x18,x14,x18
    2b5c:	00fa14b3          	sll	x9,x20,x15
    2b60:	0109da93          	srli	x21,x19,0x10
    2b64:	000a8593          	addi	x11,x21,0
    2b68:	00090513          	addi	x10,x18,0
    2b6c:	01099b13          	slli	x22,x19,0x10
    2b70:	00001097          	auipc	x1,0x1
    2b74:	b78080e7          	jalr	x1,-1160(x1) # 36e8 <__hidden___udivsi3>
    2b78:	010b5b13          	srli	x22,x22,0x10
    2b7c:	00050593          	addi	x11,x10,0
    2b80:	00050a13          	addi	x20,x10,0
    2b84:	000b0513          	addi	x10,x22,0
    2b88:	00001097          	auipc	x1,0x1
    2b8c:	aa0080e7          	jalr	x1,-1376(x1) # 3628 <__mulsi3>
    2b90:	00050413          	addi	x8,x10,0
    2b94:	000a8593          	addi	x11,x21,0
    2b98:	00090513          	addi	x10,x18,0
    2b9c:	00001097          	auipc	x1,0x1
    2ba0:	b94080e7          	jalr	x1,-1132(x1) # 3730 <__umodsi3>
    2ba4:	01051513          	slli	x10,x10,0x10
    2ba8:	0104d713          	srli	x14,x9,0x10
    2bac:	00a76733          	or	x14,x14,x10
    2bb0:	000a0913          	addi	x18,x20,0
    2bb4:	00877e63          	bgeu	x14,x8,2bd0 <__udivdi3+0x104>
    2bb8:	00e98733          	add	x14,x19,x14
    2bbc:	fffa0913          	addi	x18,x20,-1
    2bc0:	01376863          	bltu	x14,x19,2bd0 <__udivdi3+0x104>
    2bc4:	00877663          	bgeu	x14,x8,2bd0 <__udivdi3+0x104>
    2bc8:	ffea0913          	addi	x18,x20,-2
    2bcc:	01370733          	add	x14,x14,x19
    2bd0:	40870433          	sub	x8,x14,x8
    2bd4:	000a8593          	addi	x11,x21,0
    2bd8:	00040513          	addi	x10,x8,0
    2bdc:	00001097          	auipc	x1,0x1
    2be0:	b0c080e7          	jalr	x1,-1268(x1) # 36e8 <__hidden___udivsi3>
    2be4:	00050593          	addi	x11,x10,0
    2be8:	00050a13          	addi	x20,x10,0
    2bec:	000b0513          	addi	x10,x22,0
    2bf0:	00001097          	auipc	x1,0x1
    2bf4:	a38080e7          	jalr	x1,-1480(x1) # 3628 <__mulsi3>
    2bf8:	00050b13          	addi	x22,x10,0
    2bfc:	000a8593          	addi	x11,x21,0
    2c00:	00040513          	addi	x10,x8,0
    2c04:	00001097          	auipc	x1,0x1
    2c08:	b2c080e7          	jalr	x1,-1236(x1) # 3730 <__umodsi3>
    2c0c:	01049493          	slli	x9,x9,0x10
    2c10:	01051513          	slli	x10,x10,0x10
    2c14:	0104d493          	srli	x9,x9,0x10
    2c18:	00a4e4b3          	or	x9,x9,x10
    2c1c:	000a0713          	addi	x14,x20,0
    2c20:	0164fc63          	bgeu	x9,x22,2c38 <__udivdi3+0x16c>
    2c24:	009984b3          	add	x9,x19,x9
    2c28:	fffa0713          	addi	x14,x20,-1
    2c2c:	0134e663          	bltu	x9,x19,2c38 <__udivdi3+0x16c>
    2c30:	0164f463          	bgeu	x9,x22,2c38 <__udivdi3+0x16c>
    2c34:	ffea0713          	addi	x14,x20,-2
    2c38:	01091793          	slli	x15,x18,0x10
    2c3c:	00e7e7b3          	or	x15,x15,x14
    2c40:	00000913          	addi	x18,x0,0
    2c44:	1380006f          	jal	x0,2d7c <__udivdi3+0x2b0>
    2c48:	010006b7          	lui	x13,0x1000
    2c4c:	01800713          	addi	x14,x0,24
    2c50:	eed670e3          	bgeu	x12,x13,2b30 <__udivdi3+0x64>
    2c54:	01000713          	addi	x14,x0,16
    2c58:	ed9ff06f          	jal	x0,2b30 <__udivdi3+0x64>
    2c5c:	00000713          	addi	x14,x0,0
    2c60:	00060c63          	beq	x12,x0,2c78 <__udivdi3+0x1ac>
    2c64:	00010737          	lui	x14,0x10
    2c68:	14e67863          	bgeu	x12,x14,2db8 <__udivdi3+0x2ec>
    2c6c:	10063713          	sltiu	x14,x12,256
    2c70:	00173713          	sltiu	x14,x14,1
    2c74:	00371713          	slli	x14,x14,0x3
    2c78:	00e656b3          	srl	x13,x12,x14
    2c7c:	00d787b3          	add	x15,x15,x13
    2c80:	0007c783          	lbu	x15,0(x15)
    2c84:	02000693          	addi	x13,x0,32
    2c88:	00e787b3          	add	x15,x15,x14
    2c8c:	40f68733          	sub	x14,x13,x15
    2c90:	12f69e63          	bne	x13,x15,2dcc <__udivdi3+0x300>
    2c94:	40c58a33          	sub	x20,x11,x12
    2c98:	00100913          	addi	x18,x0,1
    2c9c:	0109db13          	srli	x22,x19,0x10
    2ca0:	000b0593          	addi	x11,x22,0
    2ca4:	000a0513          	addi	x10,x20,0
    2ca8:	01099b93          	slli	x23,x19,0x10
    2cac:	00001097          	auipc	x1,0x1
    2cb0:	a3c080e7          	jalr	x1,-1476(x1) # 36e8 <__hidden___udivsi3>
    2cb4:	010bdb93          	srli	x23,x23,0x10
    2cb8:	00050593          	addi	x11,x10,0
    2cbc:	00050c13          	addi	x24,x10,0
    2cc0:	000b8513          	addi	x10,x23,0
    2cc4:	00001097          	auipc	x1,0x1
    2cc8:	964080e7          	jalr	x1,-1692(x1) # 3628 <__mulsi3>
    2ccc:	00050a93          	addi	x21,x10,0
    2cd0:	000b0593          	addi	x11,x22,0
    2cd4:	000a0513          	addi	x10,x20,0
    2cd8:	00001097          	auipc	x1,0x1
    2cdc:	a58080e7          	jalr	x1,-1448(x1) # 3730 <__umodsi3>
    2ce0:	01051513          	slli	x10,x10,0x10
    2ce4:	0104d713          	srli	x14,x9,0x10
    2ce8:	00a76733          	or	x14,x14,x10
    2cec:	000c0a13          	addi	x20,x24,0
    2cf0:	01577e63          	bgeu	x14,x21,2d0c <__udivdi3+0x240>
    2cf4:	00e98733          	add	x14,x19,x14
    2cf8:	fffc0a13          	addi	x20,x24,-1
    2cfc:	01376863          	bltu	x14,x19,2d0c <__udivdi3+0x240>
    2d00:	01577663          	bgeu	x14,x21,2d0c <__udivdi3+0x240>
    2d04:	ffec0a13          	addi	x20,x24,-2
    2d08:	01370733          	add	x14,x14,x19
    2d0c:	41570433          	sub	x8,x14,x21
    2d10:	000b0593          	addi	x11,x22,0
    2d14:	00040513          	addi	x10,x8,0
    2d18:	00001097          	auipc	x1,0x1
    2d1c:	9d0080e7          	jalr	x1,-1584(x1) # 36e8 <__hidden___udivsi3>
    2d20:	00050593          	addi	x11,x10,0
    2d24:	00050a93          	addi	x21,x10,0
    2d28:	000b8513          	addi	x10,x23,0
    2d2c:	00001097          	auipc	x1,0x1
    2d30:	8fc080e7          	jalr	x1,-1796(x1) # 3628 <__mulsi3>
    2d34:	00050b93          	addi	x23,x10,0
    2d38:	000b0593          	addi	x11,x22,0
    2d3c:	00040513          	addi	x10,x8,0
    2d40:	00001097          	auipc	x1,0x1
    2d44:	9f0080e7          	jalr	x1,-1552(x1) # 3730 <__umodsi3>
    2d48:	01049493          	slli	x9,x9,0x10
    2d4c:	01051513          	slli	x10,x10,0x10
    2d50:	0104d493          	srli	x9,x9,0x10
    2d54:	00a4e4b3          	or	x9,x9,x10
    2d58:	000a8713          	addi	x14,x21,0
    2d5c:	0174fc63          	bgeu	x9,x23,2d74 <__udivdi3+0x2a8>
    2d60:	009984b3          	add	x9,x19,x9
    2d64:	fffa8713          	addi	x14,x21,-1
    2d68:	0134e663          	bltu	x9,x19,2d74 <__udivdi3+0x2a8>
    2d6c:	0174f463          	bgeu	x9,x23,2d74 <__udivdi3+0x2a8>
    2d70:	ffea8713          	addi	x14,x21,-2
    2d74:	010a1793          	slli	x15,x20,0x10
    2d78:	00e7e7b3          	or	x15,x15,x14
    2d7c:	02c12083          	lw	x1,44(x2)
    2d80:	02812403          	lw	x8,40(x2)
    2d84:	02412483          	lw	x9,36(x2)
    2d88:	01c12983          	lw	x19,28(x2)
    2d8c:	01812a03          	lw	x20,24(x2)
    2d90:	01412a83          	lw	x21,20(x2)
    2d94:	01012b03          	lw	x22,16(x2)
    2d98:	00c12b83          	lw	x23,12(x2)
    2d9c:	00812c03          	lw	x24,8(x2)
    2da0:	00412c83          	lw	x25,4(x2)
    2da4:	00090593          	addi	x11,x18,0
    2da8:	00078513          	addi	x10,x15,0
    2dac:	02012903          	lw	x18,32(x2)
    2db0:	03010113          	addi	x2,x2,48
    2db4:	00008067          	jalr	x0,0(x1)
    2db8:	010006b7          	lui	x13,0x1000
    2dbc:	01800713          	addi	x14,x0,24
    2dc0:	ead67ce3          	bgeu	x12,x13,2c78 <__udivdi3+0x1ac>
    2dc4:	01000713          	addi	x14,x0,16
    2dc8:	eb1ff06f          	jal	x0,2c78 <__udivdi3+0x1ac>
    2dcc:	00e619b3          	sll	x19,x12,x14
    2dd0:	00f5d933          	srl	x18,x11,x15
    2dd4:	0109db93          	srli	x23,x19,0x10
    2dd8:	00e595b3          	sll	x11,x11,x14
    2ddc:	00fa57b3          	srl	x15,x20,x15
    2de0:	00b7eab3          	or	x21,x15,x11
    2de4:	00ea14b3          	sll	x9,x20,x14
    2de8:	000b8593          	addi	x11,x23,0
    2dec:	00090513          	addi	x10,x18,0
    2df0:	01099a13          	slli	x20,x19,0x10
    2df4:	00001097          	auipc	x1,0x1
    2df8:	8f4080e7          	jalr	x1,-1804(x1) # 36e8 <__hidden___udivsi3>
    2dfc:	010a5a13          	srli	x20,x20,0x10
    2e00:	00050593          	addi	x11,x10,0
    2e04:	00050b13          	addi	x22,x10,0
    2e08:	000a0513          	addi	x10,x20,0
    2e0c:	00001097          	auipc	x1,0x1
    2e10:	81c080e7          	jalr	x1,-2020(x1) # 3628 <__mulsi3>
    2e14:	00050413          	addi	x8,x10,0
    2e18:	000b8593          	addi	x11,x23,0
    2e1c:	00090513          	addi	x10,x18,0
    2e20:	00001097          	auipc	x1,0x1
    2e24:	910080e7          	jalr	x1,-1776(x1) # 3730 <__umodsi3>
    2e28:	01051513          	slli	x10,x10,0x10
    2e2c:	010ad713          	srli	x14,x21,0x10
    2e30:	00a76733          	or	x14,x14,x10
    2e34:	000b0913          	addi	x18,x22,0
    2e38:	00877e63          	bgeu	x14,x8,2e54 <__udivdi3+0x388>
    2e3c:	00e98733          	add	x14,x19,x14
    2e40:	fffb0913          	addi	x18,x22,-1
    2e44:	01376863          	bltu	x14,x19,2e54 <__udivdi3+0x388>
    2e48:	00877663          	bgeu	x14,x8,2e54 <__udivdi3+0x388>
    2e4c:	ffeb0913          	addi	x18,x22,-2
    2e50:	01370733          	add	x14,x14,x19
    2e54:	40870433          	sub	x8,x14,x8
    2e58:	000b8593          	addi	x11,x23,0
    2e5c:	00040513          	addi	x10,x8,0
    2e60:	00001097          	auipc	x1,0x1
    2e64:	888080e7          	jalr	x1,-1912(x1) # 36e8 <__hidden___udivsi3>
    2e68:	00050593          	addi	x11,x10,0
    2e6c:	00050b13          	addi	x22,x10,0
    2e70:	000a0513          	addi	x10,x20,0
    2e74:	00000097          	auipc	x1,0x0
    2e78:	7b4080e7          	jalr	x1,1972(x1) # 3628 <__mulsi3>
    2e7c:	00050a13          	addi	x20,x10,0
    2e80:	000b8593          	addi	x11,x23,0
    2e84:	00040513          	addi	x10,x8,0
    2e88:	00001097          	auipc	x1,0x1
    2e8c:	8a8080e7          	jalr	x1,-1880(x1) # 3730 <__umodsi3>
    2e90:	010a9793          	slli	x15,x21,0x10
    2e94:	01051513          	slli	x10,x10,0x10
    2e98:	0107d793          	srli	x15,x15,0x10
    2e9c:	00a7e7b3          	or	x15,x15,x10
    2ea0:	000b0713          	addi	x14,x22,0
    2ea4:	0147fe63          	bgeu	x15,x20,2ec0 <__udivdi3+0x3f4>
    2ea8:	00f987b3          	add	x15,x19,x15
    2eac:	fffb0713          	addi	x14,x22,-1
    2eb0:	0137e863          	bltu	x15,x19,2ec0 <__udivdi3+0x3f4>
    2eb4:	0147f663          	bgeu	x15,x20,2ec0 <__udivdi3+0x3f4>
    2eb8:	ffeb0713          	addi	x14,x22,-2
    2ebc:	013787b3          	add	x15,x15,x19
    2ec0:	01091913          	slli	x18,x18,0x10
    2ec4:	41478a33          	sub	x20,x15,x20
    2ec8:	00e96933          	or	x18,x18,x14
    2ecc:	dd1ff06f          	jal	x0,2c9c <__udivdi3+0x1d0>
    2ed0:	22d5e263          	bltu	x11,x13,30f4 <__udivdi3+0x628>
    2ed4:	000107b7          	lui	x15,0x10
    2ed8:	04f6f463          	bgeu	x13,x15,2f20 <__udivdi3+0x454>
    2edc:	1006b713          	sltiu	x14,x13,256
    2ee0:	00173713          	sltiu	x14,x14,1
    2ee4:	00371713          	slli	x14,x14,0x3
    2ee8:	00e6d533          	srl	x10,x13,x14
    2eec:	00001797          	auipc	x15,0x1
    2ef0:	c9478793          	addi	x15,x15,-876 # 3b80 <__clz_tab>
    2ef4:	00a787b3          	add	x15,x15,x10
    2ef8:	0007c803          	lbu	x16,0(x15)
    2efc:	02000793          	addi	x15,x0,32
    2f00:	00e80833          	add	x16,x16,x14
    2f04:	41078933          	sub	x18,x15,x16
    2f08:	03079663          	bne	x15,x16,2f34 <__udivdi3+0x468>
    2f0c:	00100793          	addi	x15,x0,1
    2f10:	e6b6e6e3          	bltu	x13,x11,2d7c <__udivdi3+0x2b0>
    2f14:	00ca37b3          	sltu	x15,x20,x12
    2f18:	0017b793          	sltiu	x15,x15,1
    2f1c:	e61ff06f          	jal	x0,2d7c <__udivdi3+0x2b0>
    2f20:	010007b7          	lui	x15,0x1000
    2f24:	01800713          	addi	x14,x0,24
    2f28:	fcf6f0e3          	bgeu	x13,x15,2ee8 <__udivdi3+0x41c>
    2f2c:	01000713          	addi	x14,x0,16
    2f30:	fb9ff06f          	jal	x0,2ee8 <__udivdi3+0x41c>
    2f34:	012696b3          	sll	x13,x13,x18
    2f38:	01065b33          	srl	x22,x12,x16
    2f3c:	00db6b33          	or	x22,x22,x13
    2f40:	0105d4b3          	srl	x9,x11,x16
    2f44:	010b5c13          	srli	x24,x22,0x10
    2f48:	010a5833          	srl	x16,x20,x16
    2f4c:	012595b3          	sll	x11,x11,x18
    2f50:	00b869b3          	or	x19,x16,x11
    2f54:	00048513          	addi	x10,x9,0
    2f58:	000c0593          	addi	x11,x24,0
    2f5c:	010b1b93          	slli	x23,x22,0x10
    2f60:	01261433          	sll	x8,x12,x18
    2f64:	010bdb93          	srli	x23,x23,0x10
    2f68:	00000097          	auipc	x1,0x0
    2f6c:	780080e7          	jalr	x1,1920(x1) # 36e8 <__hidden___udivsi3>
    2f70:	00050593          	addi	x11,x10,0
    2f74:	00050c93          	addi	x25,x10,0
    2f78:	000b8513          	addi	x10,x23,0
    2f7c:	00000097          	auipc	x1,0x0
    2f80:	6ac080e7          	jalr	x1,1708(x1) # 3628 <__mulsi3>
    2f84:	00050a93          	addi	x21,x10,0
    2f88:	000c0593          	addi	x11,x24,0
    2f8c:	00048513          	addi	x10,x9,0
    2f90:	00000097          	auipc	x1,0x0
    2f94:	7a0080e7          	jalr	x1,1952(x1) # 3730 <__umodsi3>
    2f98:	01051513          	slli	x10,x10,0x10
    2f9c:	0109d693          	srli	x13,x19,0x10
    2fa0:	00a6e6b3          	or	x13,x13,x10
    2fa4:	000c8493          	addi	x9,x25,0
    2fa8:	0156fe63          	bgeu	x13,x21,2fc4 <__udivdi3+0x4f8>
    2fac:	00db06b3          	add	x13,x22,x13
    2fb0:	fffc8493          	addi	x9,x25,-1
    2fb4:	0166e863          	bltu	x13,x22,2fc4 <__udivdi3+0x4f8>
    2fb8:	0156f663          	bgeu	x13,x21,2fc4 <__udivdi3+0x4f8>
    2fbc:	ffec8493          	addi	x9,x25,-2
    2fc0:	016686b3          	add	x13,x13,x22
    2fc4:	41568ab3          	sub	x21,x13,x21
    2fc8:	000c0593          	addi	x11,x24,0
    2fcc:	000a8513          	addi	x10,x21,0
    2fd0:	00000097          	auipc	x1,0x0
    2fd4:	718080e7          	jalr	x1,1816(x1) # 36e8 <__hidden___udivsi3>
    2fd8:	00050593          	addi	x11,x10,0
    2fdc:	00050c93          	addi	x25,x10,0
    2fe0:	000b8513          	addi	x10,x23,0
    2fe4:	00000097          	auipc	x1,0x0
    2fe8:	644080e7          	jalr	x1,1604(x1) # 3628 <__mulsi3>
    2fec:	00050b93          	addi	x23,x10,0
    2ff0:	000c0593          	addi	x11,x24,0
    2ff4:	000a8513          	addi	x10,x21,0
    2ff8:	00000097          	auipc	x1,0x0
    2ffc:	738080e7          	jalr	x1,1848(x1) # 3730 <__umodsi3>
    3000:	01099713          	slli	x14,x19,0x10
    3004:	01051513          	slli	x10,x10,0x10
    3008:	01075713          	srli	x14,x14,0x10
    300c:	00a76733          	or	x14,x14,x10
    3010:	000c8693          	addi	x13,x25,0
    3014:	01777e63          	bgeu	x14,x23,3030 <__udivdi3+0x564>
    3018:	00eb0733          	add	x14,x22,x14
    301c:	fffc8693          	addi	x13,x25,-1
    3020:	01676863          	bltu	x14,x22,3030 <__udivdi3+0x564>
    3024:	01777663          	bgeu	x14,x23,3030 <__udivdi3+0x564>
    3028:	ffec8693          	addi	x13,x25,-2
    302c:	01670733          	add	x14,x14,x22
    3030:	01049793          	slli	x15,x9,0x10
    3034:	00010e37          	lui	x28,0x10
    3038:	00d7e7b3          	or	x15,x15,x13
    303c:	fffe0313          	addi	x6,x28,-1 # ffff <_bss_end+0xa554>
    3040:	0067f8b3          	and	x17,x15,x6
    3044:	00647333          	and	x6,x8,x6
    3048:	41770733          	sub	x14,x14,x23
    304c:	0107de93          	srli	x29,x15,0x10
    3050:	01045413          	srli	x8,x8,0x10
    3054:	00088513          	addi	x10,x17,0
    3058:	00030593          	addi	x11,x6,0
    305c:	00000097          	auipc	x1,0x0
    3060:	5cc080e7          	jalr	x1,1484(x1) # 3628 <__mulsi3>
    3064:	00050813          	addi	x16,x10,0
    3068:	00040593          	addi	x11,x8,0
    306c:	00088513          	addi	x10,x17,0
    3070:	00000097          	auipc	x1,0x0
    3074:	5b8080e7          	jalr	x1,1464(x1) # 3628 <__mulsi3>
    3078:	00050893          	addi	x17,x10,0
    307c:	00030593          	addi	x11,x6,0
    3080:	000e8513          	addi	x10,x29,0
    3084:	00000097          	auipc	x1,0x0
    3088:	5a4080e7          	jalr	x1,1444(x1) # 3628 <__mulsi3>
    308c:	00050313          	addi	x6,x10,0
    3090:	00040593          	addi	x11,x8,0
    3094:	000e8513          	addi	x10,x29,0
    3098:	00000097          	auipc	x1,0x0
    309c:	590080e7          	jalr	x1,1424(x1) # 3628 <__mulsi3>
    30a0:	01085693          	srli	x13,x16,0x10
    30a4:	006888b3          	add	x17,x17,x6
    30a8:	011686b3          	add	x13,x13,x17
    30ac:	00050613          	addi	x12,x10,0
    30b0:	0066f463          	bgeu	x13,x6,30b8 <__udivdi3+0x5ec>
    30b4:	01c50633          	add	x12,x10,x28
    30b8:	0106d593          	srli	x11,x13,0x10
    30bc:	00c58633          	add	x12,x11,x12
    30c0:	02c76663          	bltu	x14,x12,30ec <__udivdi3+0x620>
    30c4:	b6c71ee3          	bne	x14,x12,2c40 <__udivdi3+0x174>
    30c8:	00010637          	lui	x12,0x10
    30cc:	fff60613          	addi	x12,x12,-1 # ffff <_bss_end+0xa554>
    30d0:	00c6f6b3          	and	x13,x13,x12
    30d4:	01069693          	slli	x13,x13,0x10
    30d8:	00c87833          	and	x16,x16,x12
    30dc:	012a1733          	sll	x14,x20,x18
    30e0:	010686b3          	add	x13,x13,x16
    30e4:	00000913          	addi	x18,x0,0
    30e8:	c8d77ae3          	bgeu	x14,x13,2d7c <__udivdi3+0x2b0>
    30ec:	fff78793          	addi	x15,x15,-1 # ffffff <_stack_ptr+0xfeffff>
    30f0:	b51ff06f          	jal	x0,2c40 <__udivdi3+0x174>
    30f4:	00000913          	addi	x18,x0,0
    30f8:	00000793          	addi	x15,x0,0
    30fc:	c81ff06f          	jal	x0,2d7c <__udivdi3+0x2b0>

00003100 <__umoddi3>:
    3100:	fd010113          	addi	x2,x2,-48
    3104:	02812423          	sw	x8,40(x2)
    3108:	02912223          	sw	x9,36(x2)
    310c:	02112623          	sw	x1,44(x2)
    3110:	03212023          	sw	x18,32(x2)
    3114:	01312e23          	sw	x19,28(x2)
    3118:	01412c23          	sw	x20,24(x2)
    311c:	01512a23          	sw	x21,20(x2)
    3120:	01612823          	sw	x22,16(x2)
    3124:	01712623          	sw	x23,12(x2)
    3128:	01812423          	sw	x24,8(x2)
    312c:	01912223          	sw	x25,4(x2)
    3130:	01a12023          	sw	x26,0(x2)
    3134:	00050413          	addi	x8,x10,0
    3138:	00058493          	addi	x9,x11,0
    313c:	28069463          	bne	x13,x0,33c4 <__umoddi3+0x2c4>
    3140:	00060993          	addi	x19,x12,0
    3144:	00001697          	auipc	x13,0x1
    3148:	a3c68693          	addi	x13,x13,-1476 # 3b80 <__clz_tab>
    314c:	14c5fa63          	bgeu	x11,x12,32a0 <__umoddi3+0x1a0>
    3150:	000107b7          	lui	x15,0x10
    3154:	12f67c63          	bgeu	x12,x15,328c <__umoddi3+0x18c>
    3158:	10063793          	sltiu	x15,x12,256
    315c:	0017b793          	sltiu	x15,x15,1
    3160:	00379793          	slli	x15,x15,0x3
    3164:	00f65733          	srl	x14,x12,x15
    3168:	00e686b3          	add	x13,x13,x14
    316c:	0006c703          	lbu	x14,0(x13)
    3170:	00f707b3          	add	x15,x14,x15
    3174:	02000713          	addi	x14,x0,32
    3178:	40f70933          	sub	x18,x14,x15
    317c:	00f70c63          	beq	x14,x15,3194 <__umoddi3+0x94>
    3180:	012594b3          	sll	x9,x11,x18
    3184:	00f557b3          	srl	x15,x10,x15
    3188:	012619b3          	sll	x19,x12,x18
    318c:	0097e4b3          	or	x9,x15,x9
    3190:	01251433          	sll	x8,x10,x18
    3194:	0109da93          	srli	x21,x19,0x10
    3198:	000a8593          	addi	x11,x21,0
    319c:	01099b13          	slli	x22,x19,0x10
    31a0:	00048513          	addi	x10,x9,0
    31a4:	00000097          	auipc	x1,0x0
    31a8:	544080e7          	jalr	x1,1348(x1) # 36e8 <__hidden___udivsi3>
    31ac:	010b5b13          	srli	x22,x22,0x10
    31b0:	000b0593          	addi	x11,x22,0
    31b4:	00000097          	auipc	x1,0x0
    31b8:	474080e7          	jalr	x1,1140(x1) # 3628 <__mulsi3>
    31bc:	00050a13          	addi	x20,x10,0
    31c0:	000a8593          	addi	x11,x21,0
    31c4:	00048513          	addi	x10,x9,0
    31c8:	00000097          	auipc	x1,0x0
    31cc:	568080e7          	jalr	x1,1384(x1) # 3730 <__umodsi3>
    31d0:	01051513          	slli	x10,x10,0x10
    31d4:	01045793          	srli	x15,x8,0x10
    31d8:	00a7e7b3          	or	x15,x15,x10
    31dc:	0147fa63          	bgeu	x15,x20,31f0 <__umoddi3+0xf0>
    31e0:	00f987b3          	add	x15,x19,x15
    31e4:	0137e663          	bltu	x15,x19,31f0 <__umoddi3+0xf0>
    31e8:	0147f463          	bgeu	x15,x20,31f0 <__umoddi3+0xf0>
    31ec:	013787b3          	add	x15,x15,x19
    31f0:	414784b3          	sub	x9,x15,x20
    31f4:	000a8593          	addi	x11,x21,0
    31f8:	00048513          	addi	x10,x9,0
    31fc:	00000097          	auipc	x1,0x0
    3200:	4ec080e7          	jalr	x1,1260(x1) # 36e8 <__hidden___udivsi3>
    3204:	000b0593          	addi	x11,x22,0
    3208:	00000097          	auipc	x1,0x0
    320c:	420080e7          	jalr	x1,1056(x1) # 3628 <__mulsi3>
    3210:	00050a13          	addi	x20,x10,0
    3214:	000a8593          	addi	x11,x21,0
    3218:	00048513          	addi	x10,x9,0
    321c:	00000097          	auipc	x1,0x0
    3220:	514080e7          	jalr	x1,1300(x1) # 3730 <__umodsi3>
    3224:	01041413          	slli	x8,x8,0x10
    3228:	01051513          	slli	x10,x10,0x10
    322c:	01045413          	srli	x8,x8,0x10
    3230:	00a46433          	or	x8,x8,x10
    3234:	01447a63          	bgeu	x8,x20,3248 <__umoddi3+0x148>
    3238:	00898433          	add	x8,x19,x8
    323c:	01346663          	bltu	x8,x19,3248 <__umoddi3+0x148>
    3240:	01447463          	bgeu	x8,x20,3248 <__umoddi3+0x148>
    3244:	01340433          	add	x8,x8,x19
    3248:	41440433          	sub	x8,x8,x20
    324c:	01245533          	srl	x10,x8,x18
    3250:	00000593          	addi	x11,x0,0
    3254:	02c12083          	lw	x1,44(x2)
    3258:	02812403          	lw	x8,40(x2)
    325c:	02412483          	lw	x9,36(x2)
    3260:	02012903          	lw	x18,32(x2)
    3264:	01c12983          	lw	x19,28(x2)
    3268:	01812a03          	lw	x20,24(x2)
    326c:	01412a83          	lw	x21,20(x2)
    3270:	01012b03          	lw	x22,16(x2)
    3274:	00c12b83          	lw	x23,12(x2)
    3278:	00812c03          	lw	x24,8(x2)
    327c:	00412c83          	lw	x25,4(x2)
    3280:	00012d03          	lw	x26,0(x2)
    3284:	03010113          	addi	x2,x2,48
    3288:	00008067          	jalr	x0,0(x1)
    328c:	01000737          	lui	x14,0x1000
    3290:	01800793          	addi	x15,x0,24
    3294:	ece678e3          	bgeu	x12,x14,3164 <__umoddi3+0x64>
    3298:	01000793          	addi	x15,x0,16
    329c:	ec9ff06f          	jal	x0,3164 <__umoddi3+0x64>
    32a0:	00000713          	addi	x14,x0,0
    32a4:	00060c63          	beq	x12,x0,32bc <__umoddi3+0x1bc>
    32a8:	000107b7          	lui	x15,0x10
    32ac:	10f67263          	bgeu	x12,x15,33b0 <__umoddi3+0x2b0>
    32b0:	10063713          	sltiu	x14,x12,256
    32b4:	00173713          	sltiu	x14,x14,1
    32b8:	00371713          	slli	x14,x14,0x3
    32bc:	00e657b3          	srl	x15,x12,x14
    32c0:	00f686b3          	add	x13,x13,x15
    32c4:	0006c783          	lbu	x15,0(x13)
    32c8:	40c584b3          	sub	x9,x11,x12
    32cc:	00e787b3          	add	x15,x15,x14
    32d0:	02000713          	addi	x14,x0,32
    32d4:	40f70933          	sub	x18,x14,x15
    32d8:	eaf70ee3          	beq	x14,x15,3194 <__umoddi3+0x94>
    32dc:	012619b3          	sll	x19,x12,x18
    32e0:	00f5dbb3          	srl	x23,x11,x15
    32e4:	0109db13          	srli	x22,x19,0x10
    32e8:	00f557b3          	srl	x15,x10,x15
    32ec:	012595b3          	sll	x11,x11,x18
    32f0:	00b7ea33          	or	x20,x15,x11
    32f4:	01251433          	sll	x8,x10,x18
    32f8:	000b0593          	addi	x11,x22,0
    32fc:	01099a93          	slli	x21,x19,0x10
    3300:	000b8513          	addi	x10,x23,0
    3304:	00000097          	auipc	x1,0x0
    3308:	3e4080e7          	jalr	x1,996(x1) # 36e8 <__hidden___udivsi3>
    330c:	010ada93          	srli	x21,x21,0x10
    3310:	000a8593          	addi	x11,x21,0
    3314:	00000097          	auipc	x1,0x0
    3318:	314080e7          	jalr	x1,788(x1) # 3628 <__mulsi3>
    331c:	00050493          	addi	x9,x10,0
    3320:	000b0593          	addi	x11,x22,0
    3324:	000b8513          	addi	x10,x23,0
    3328:	00000097          	auipc	x1,0x0
    332c:	408080e7          	jalr	x1,1032(x1) # 3730 <__umodsi3>
    3330:	01051513          	slli	x10,x10,0x10
    3334:	010a5713          	srli	x14,x20,0x10
    3338:	00a76733          	or	x14,x14,x10
    333c:	00977a63          	bgeu	x14,x9,3350 <__umoddi3+0x250>
    3340:	00e98733          	add	x14,x19,x14
    3344:	01376663          	bltu	x14,x19,3350 <__umoddi3+0x250>
    3348:	00977463          	bgeu	x14,x9,3350 <__umoddi3+0x250>
    334c:	01370733          	add	x14,x14,x19
    3350:	409704b3          	sub	x9,x14,x9
    3354:	000b0593          	addi	x11,x22,0
    3358:	00048513          	addi	x10,x9,0
    335c:	00000097          	auipc	x1,0x0
    3360:	38c080e7          	jalr	x1,908(x1) # 36e8 <__hidden___udivsi3>
    3364:	000a8593          	addi	x11,x21,0
    3368:	00000097          	auipc	x1,0x0
    336c:	2c0080e7          	jalr	x1,704(x1) # 3628 <__mulsi3>
    3370:	00050a93          	addi	x21,x10,0
    3374:	000b0593          	addi	x11,x22,0
    3378:	00048513          	addi	x10,x9,0
    337c:	00000097          	auipc	x1,0x0
    3380:	3b4080e7          	jalr	x1,948(x1) # 3730 <__umodsi3>
    3384:	010a1793          	slli	x15,x20,0x10
    3388:	01051513          	slli	x10,x10,0x10
    338c:	0107d793          	srli	x15,x15,0x10
    3390:	00a7e7b3          	or	x15,x15,x10
    3394:	0157fa63          	bgeu	x15,x21,33a8 <__umoddi3+0x2a8>
    3398:	00f987b3          	add	x15,x19,x15
    339c:	0137e663          	bltu	x15,x19,33a8 <__umoddi3+0x2a8>
    33a0:	0157f463          	bgeu	x15,x21,33a8 <__umoddi3+0x2a8>
    33a4:	013787b3          	add	x15,x15,x19
    33a8:	415784b3          	sub	x9,x15,x21
    33ac:	de9ff06f          	jal	x0,3194 <__umoddi3+0x94>
    33b0:	010007b7          	lui	x15,0x1000
    33b4:	01800713          	addi	x14,x0,24
    33b8:	f0f672e3          	bgeu	x12,x15,32bc <__umoddi3+0x1bc>
    33bc:	01000713          	addi	x14,x0,16
    33c0:	efdff06f          	jal	x0,32bc <__umoddi3+0x1bc>
    33c4:	e8d5e8e3          	bltu	x11,x13,3254 <__umoddi3+0x154>
    33c8:	000107b7          	lui	x15,0x10
    33cc:	04f6fe63          	bgeu	x13,x15,3428 <__umoddi3+0x328>
    33d0:	1006b793          	sltiu	x15,x13,256
    33d4:	0017b793          	sltiu	x15,x15,1
    33d8:	00379793          	slli	x15,x15,0x3
    33dc:	00f6d833          	srl	x16,x13,x15
    33e0:	00000717          	auipc	x14,0x0
    33e4:	7a070713          	addi	x14,x14,1952 # 3b80 <__clz_tab>
    33e8:	01070733          	add	x14,x14,x16
    33ec:	00074a83          	lbu	x21,0(x14)
    33f0:	00fa8ab3          	add	x21,x21,x15
    33f4:	02000793          	addi	x15,x0,32
    33f8:	41578a33          	sub	x20,x15,x21
    33fc:	05579063          	bne	x15,x21,343c <__umoddi3+0x33c>
    3400:	00b6e463          	bltu	x13,x11,3408 <__umoddi3+0x308>
    3404:	00c56c63          	bltu	x10,x12,341c <__umoddi3+0x31c>
    3408:	40c50933          	sub	x18,x10,x12
    340c:	40d586b3          	sub	x13,x11,x13
    3410:	012534b3          	sltu	x9,x10,x18
    3414:	00090413          	addi	x8,x18,0
    3418:	409684b3          	sub	x9,x13,x9
    341c:	00040513          	addi	x10,x8,0
    3420:	00048593          	addi	x11,x9,0
    3424:	e31ff06f          	jal	x0,3254 <__umoddi3+0x154>
    3428:	01000737          	lui	x14,0x1000
    342c:	01800793          	addi	x15,x0,24
    3430:	fae6f6e3          	bgeu	x13,x14,33dc <__umoddi3+0x2dc>
    3434:	01000793          	addi	x15,x0,16
    3438:	fa5ff06f          	jal	x0,33dc <__umoddi3+0x2dc>
    343c:	014696b3          	sll	x13,x13,x20
    3440:	01565bb3          	srl	x23,x12,x21
    3444:	00dbebb3          	or	x23,x23,x13
    3448:	0155d9b3          	srl	x19,x11,x21
    344c:	01555433          	srl	x8,x10,x21
    3450:	014595b3          	sll	x11,x11,x20
    3454:	010bd493          	srli	x9,x23,0x10
    3458:	00b46433          	or	x8,x8,x11
    345c:	01451b33          	sll	x22,x10,x20
    3460:	00048593          	addi	x11,x9,0
    3464:	00098513          	addi	x10,x19,0
    3468:	010b9c13          	slli	x24,x23,0x10
    346c:	01461933          	sll	x18,x12,x20
    3470:	010c5c13          	srli	x24,x24,0x10
    3474:	00000097          	auipc	x1,0x0
    3478:	274080e7          	jalr	x1,628(x1) # 36e8 <__hidden___udivsi3>
    347c:	00050593          	addi	x11,x10,0
    3480:	00050d13          	addi	x26,x10,0
    3484:	000c0513          	addi	x10,x24,0
    3488:	00000097          	auipc	x1,0x0
    348c:	1a0080e7          	jalr	x1,416(x1) # 3628 <__mulsi3>
    3490:	00050c93          	addi	x25,x10,0
    3494:	00048593          	addi	x11,x9,0
    3498:	00098513          	addi	x10,x19,0
    349c:	00000097          	auipc	x1,0x0
    34a0:	294080e7          	jalr	x1,660(x1) # 3730 <__umodsi3>
    34a4:	01051513          	slli	x10,x10,0x10
    34a8:	01045793          	srli	x15,x8,0x10
    34ac:	00a7e7b3          	or	x15,x15,x10
    34b0:	000d0993          	addi	x19,x26,0
    34b4:	0197fe63          	bgeu	x15,x25,34d0 <__umoddi3+0x3d0>
    34b8:	00fb87b3          	add	x15,x23,x15
    34bc:	fffd0993          	addi	x19,x26,-1
    34c0:	0177e863          	bltu	x15,x23,34d0 <__umoddi3+0x3d0>
    34c4:	0197f663          	bgeu	x15,x25,34d0 <__umoddi3+0x3d0>
    34c8:	ffed0993          	addi	x19,x26,-2
    34cc:	017787b3          	add	x15,x15,x23
    34d0:	41978cb3          	sub	x25,x15,x25
    34d4:	00048593          	addi	x11,x9,0
    34d8:	000c8513          	addi	x10,x25,0
    34dc:	00000097          	auipc	x1,0x0
    34e0:	20c080e7          	jalr	x1,524(x1) # 36e8 <__hidden___udivsi3>
    34e4:	00050593          	addi	x11,x10,0
    34e8:	00050d13          	addi	x26,x10,0
    34ec:	000c0513          	addi	x10,x24,0
    34f0:	00000097          	auipc	x1,0x0
    34f4:	138080e7          	jalr	x1,312(x1) # 3628 <__mulsi3>
    34f8:	00048593          	addi	x11,x9,0
    34fc:	00050c13          	addi	x24,x10,0
    3500:	000c8513          	addi	x10,x25,0
    3504:	00000097          	auipc	x1,0x0
    3508:	22c080e7          	jalr	x1,556(x1) # 3730 <__umodsi3>
    350c:	01041593          	slli	x11,x8,0x10
    3510:	01051513          	slli	x10,x10,0x10
    3514:	0105d593          	srli	x11,x11,0x10
    3518:	00a5e5b3          	or	x11,x11,x10
    351c:	000d0793          	addi	x15,x26,0
    3520:	0185fe63          	bgeu	x11,x24,353c <__umoddi3+0x43c>
    3524:	00bb85b3          	add	x11,x23,x11
    3528:	fffd0793          	addi	x15,x26,-1
    352c:	0175e863          	bltu	x11,x23,353c <__umoddi3+0x43c>
    3530:	0185f663          	bgeu	x11,x24,353c <__umoddi3+0x43c>
    3534:	ffed0793          	addi	x15,x26,-2
    3538:	017585b3          	add	x11,x11,x23
    353c:	00010e37          	lui	x28,0x10
    3540:	01099993          	slli	x19,x19,0x10
    3544:	00f9e9b3          	or	x19,x19,x15
    3548:	fffe0793          	addi	x15,x28,-1 # ffff <_bss_end+0xa554>
    354c:	00f9f733          	and	x14,x19,x15
    3550:	00f977b3          	and	x15,x18,x15
    3554:	418584b3          	sub	x9,x11,x24
    3558:	0109d993          	srli	x19,x19,0x10
    355c:	01095313          	srli	x6,x18,0x10
    3560:	00070513          	addi	x10,x14,0 # 1000000 <_stack_ptr+0xff0000>
    3564:	00078593          	addi	x11,x15,0 # 10000 <_stack_ptr>
    3568:	00000097          	auipc	x1,0x0
    356c:	0c0080e7          	jalr	x1,192(x1) # 3628 <__mulsi3>
    3570:	00050813          	addi	x16,x10,0
    3574:	00030593          	addi	x11,x6,0
    3578:	00070513          	addi	x10,x14,0
    357c:	00000097          	auipc	x1,0x0
    3580:	0ac080e7          	jalr	x1,172(x1) # 3628 <__mulsi3>
    3584:	00050713          	addi	x14,x10,0
    3588:	00078593          	addi	x11,x15,0
    358c:	00098513          	addi	x10,x19,0
    3590:	00000097          	auipc	x1,0x0
    3594:	098080e7          	jalr	x1,152(x1) # 3628 <__mulsi3>
    3598:	00050893          	addi	x17,x10,0
    359c:	00030593          	addi	x11,x6,0
    35a0:	00098513          	addi	x10,x19,0
    35a4:	00000097          	auipc	x1,0x0
    35a8:	084080e7          	jalr	x1,132(x1) # 3628 <__mulsi3>
    35ac:	01085793          	srli	x15,x16,0x10
    35b0:	01170733          	add	x14,x14,x17
    35b4:	00e787b3          	add	x15,x15,x14
    35b8:	00050693          	addi	x13,x10,0
    35bc:	0117f463          	bgeu	x15,x17,35c4 <__umoddi3+0x4c4>
    35c0:	01c506b3          	add	x13,x10,x28
    35c4:	0107d713          	srli	x14,x15,0x10
    35c8:	00d70733          	add	x14,x14,x13
    35cc:	000106b7          	lui	x13,0x10
    35d0:	fff68693          	addi	x13,x13,-1 # ffff <_bss_end+0xa554>
    35d4:	00d7f7b3          	and	x15,x15,x13
    35d8:	01079793          	slli	x15,x15,0x10
    35dc:	00d87833          	and	x16,x16,x13
    35e0:	010787b3          	add	x15,x15,x16
    35e4:	00e4e663          	bltu	x9,x14,35f0 <__umoddi3+0x4f0>
    35e8:	00e49e63          	bne	x9,x14,3604 <__umoddi3+0x504>
    35ec:	00fb7c63          	bgeu	x22,x15,3604 <__umoddi3+0x504>
    35f0:	41278933          	sub	x18,x15,x18
    35f4:	0127b6b3          	sltu	x13,x15,x18
    35f8:	017686b3          	add	x13,x13,x23
    35fc:	00090793          	addi	x15,x18,0
    3600:	40d70733          	sub	x14,x14,x13
    3604:	40fb07b3          	sub	x15,x22,x15
    3608:	00fb3b33          	sltu	x22,x22,x15
    360c:	40e485b3          	sub	x11,x9,x14
    3610:	416585b3          	sub	x11,x11,x22
    3614:	01559ab3          	sll	x21,x11,x21
    3618:	0147d7b3          	srl	x15,x15,x20
    361c:	00fae533          	or	x10,x21,x15
    3620:	0145d5b3          	srl	x11,x11,x20
    3624:	c31ff06f          	jal	x0,3254 <__umoddi3+0x154>

00003628 <__mulsi3>:
    3628:	00050613          	addi	x12,x10,0
    362c:	00000513          	addi	x10,x0,0
    3630:	0015f693          	andi	x13,x11,1
    3634:	00068463          	beq	x13,x0,363c <__mulsi3+0x14>
    3638:	00c50533          	add	x10,x10,x12
    363c:	0015d593          	srli	x11,x11,0x1
    3640:	00161613          	slli	x12,x12,0x1
    3644:	fe0596e3          	bne	x11,x0,3630 <__mulsi3+0x8>
    3648:	00008067          	jalr	x0,0(x1)

0000364c <__muldi3>:
    364c:	00050e13          	addi	x28,x10,0
    3650:	ff010113          	addi	x2,x2,-16
    3654:	00068313          	addi	x6,x13,0
    3658:	00112623          	sw	x1,12(x2)
    365c:	00060513          	addi	x10,x12,0
    3660:	000e0893          	addi	x17,x28,0
    3664:	00060693          	addi	x13,x12,0
    3668:	00000713          	addi	x14,x0,0
    366c:	00000793          	addi	x15,x0,0
    3670:	00000813          	addi	x16,x0,0
    3674:	0016fe93          	andi	x29,x13,1
    3678:	00171613          	slli	x12,x14,0x1
    367c:	000e8a63          	beq	x29,x0,3690 <__muldi3+0x44>
    3680:	01088833          	add	x16,x17,x16
    3684:	00e787b3          	add	x15,x15,x14
    3688:	01183733          	sltu	x14,x16,x17
    368c:	00f707b3          	add	x15,x14,x15
    3690:	01f8d713          	srli	x14,x17,0x1f
    3694:	0016d693          	srli	x13,x13,0x1
    3698:	00e66733          	or	x14,x12,x14
    369c:	00189893          	slli	x17,x17,0x1
    36a0:	fc069ae3          	bne	x13,x0,3674 <__muldi3+0x28>
    36a4:	00058863          	beq	x11,x0,36b4 <__muldi3+0x68>
    36a8:	00000097          	auipc	x1,0x0
    36ac:	f80080e7          	jalr	x1,-128(x1) # 3628 <__mulsi3>
    36b0:	00a787b3          	add	x15,x15,x10
    36b4:	00030c63          	beq	x6,x0,36cc <__muldi3+0x80>
    36b8:	000e0513          	addi	x10,x28,0
    36bc:	00030593          	addi	x11,x6,0
    36c0:	00000097          	auipc	x1,0x0
    36c4:	f68080e7          	jalr	x1,-152(x1) # 3628 <__mulsi3>
    36c8:	00f507b3          	add	x15,x10,x15
    36cc:	00c12083          	lw	x1,12(x2)
    36d0:	00080513          	addi	x10,x16,0
    36d4:	00078593          	addi	x11,x15,0
    36d8:	01010113          	addi	x2,x2,16
    36dc:	00008067          	jalr	x0,0(x1)

000036e0 <__divsi3>:
    36e0:	06054063          	blt	x10,x0,3740 <__umodsi3+0x10>
    36e4:	0605c663          	blt	x11,x0,3750 <__umodsi3+0x20>

000036e8 <__hidden___udivsi3>:
    36e8:	00058613          	addi	x12,x11,0
    36ec:	00050593          	addi	x11,x10,0
    36f0:	fff00513          	addi	x10,x0,-1
    36f4:	02060c63          	beq	x12,x0,372c <__hidden___udivsi3+0x44>
    36f8:	00100693          	addi	x13,x0,1
    36fc:	00b67a63          	bgeu	x12,x11,3710 <__hidden___udivsi3+0x28>
    3700:	00c05863          	bge	x0,x12,3710 <__hidden___udivsi3+0x28>
    3704:	00161613          	slli	x12,x12,0x1
    3708:	00169693          	slli	x13,x13,0x1
    370c:	feb66ae3          	bltu	x12,x11,3700 <__hidden___udivsi3+0x18>
    3710:	00000513          	addi	x10,x0,0
    3714:	00c5e663          	bltu	x11,x12,3720 <__hidden___udivsi3+0x38>
    3718:	40c585b3          	sub	x11,x11,x12
    371c:	00d56533          	or	x10,x10,x13
    3720:	0016d693          	srli	x13,x13,0x1
    3724:	00165613          	srli	x12,x12,0x1
    3728:	fe0696e3          	bne	x13,x0,3714 <__hidden___udivsi3+0x2c>
    372c:	00008067          	jalr	x0,0(x1)

00003730 <__umodsi3>:
    3730:	00008293          	addi	x5,x1,0
    3734:	fb5ff0ef          	jal	x1,36e8 <__hidden___udivsi3>
    3738:	00058513          	addi	x10,x11,0
    373c:	00028067          	jalr	x0,0(x5)
    3740:	40a00533          	sub	x10,x0,x10
    3744:	00b04863          	blt	x0,x11,3754 <__umodsi3+0x24>
    3748:	40b005b3          	sub	x11,x0,x11
    374c:	f9dff06f          	jal	x0,36e8 <__hidden___udivsi3>
    3750:	40b005b3          	sub	x11,x0,x11
    3754:	00008293          	addi	x5,x1,0
    3758:	f91ff0ef          	jal	x1,36e8 <__hidden___udivsi3>
    375c:	40a00533          	sub	x10,x0,x10
    3760:	00028067          	jalr	x0,0(x5)

00003764 <__modsi3>:
    3764:	00008293          	addi	x5,x1,0
    3768:	0005ca63          	blt	x11,x0,377c <__modsi3+0x18>
    376c:	00054c63          	blt	x10,x0,3784 <__modsi3+0x20>
    3770:	f79ff0ef          	jal	x1,36e8 <__hidden___udivsi3>
    3774:	00058513          	addi	x10,x11,0
    3778:	00028067          	jalr	x0,0(x5)
    377c:	40b005b3          	sub	x11,x0,x11
    3780:	fe0558e3          	bge	x10,x0,3770 <__modsi3+0xc>
    3784:	40a00533          	sub	x10,x0,x10
    3788:	f61ff0ef          	jal	x1,36e8 <__hidden___udivsi3>
    378c:	40b00533          	sub	x10,x0,x11
    3790:	00028067          	jalr	x0,0(x5)
    3794:	4944                	.insn	2, 0x4944
    3796:	3056                	.insn	2, 0x3056
    3798:	0000                	.insn	2, 0x
    379a:	0000                	.insn	2, 0x
    379c:	5245                	.insn	2, 0x5245
    379e:	4f52                	.insn	2, 0x4f52
    37a0:	0052                	.insn	2, 0x0052
    37a2:	0000                	.insn	2, 0x
    37a4:	4d45                	.insn	2, 0x4d45
    37a6:	5450                	.insn	2, 0x5450
    37a8:	0059                	.insn	2, 0x0059
    37aa:	0000                	.insn	2, 0x
    37ac:	414e                	.insn	2, 0x414e
    37ae:	004e                	.insn	2, 0x004e
    37b0:	492d                	.insn	2, 0x492d
    37b2:	464e                	.insn	2, 0x464e
    37b4:	0000                	.insn	2, 0x
    37b6:	0000                	.insn	2, 0x
    37b8:	4e49                	.insn	2, 0x4e49
    37ba:	0046                	.insn	2, 0x0046
    37bc:	0030                	.insn	2, 0x0030
    37be:	0000                	.insn	2, 0x
    37c0:	5245564f          	.insn	4, 0x5245564f
    37c4:	4c46                	.insn	2, 0x4c46
    37c6:	0000574f          	fnmadd.s	f14,f0,f0,f0,unknown
    37ca:	0000                	.insn	2, 0x
    37cc:	52e8                	.insn	2, 0x52e8
    37ce:	0000                	.insn	2, 0x
    37d0:	4f64                	.insn	2, 0x4f64
    37d2:	0000                	.insn	2, 0x
    37d4:	4098                	.insn	2, 0x4098
    37d6:	0000                	.insn	2, 0x
    37d8:	4098                	.insn	2, 0x4098
    37da:	0000                	.insn	2, 0x
    37dc:	4098                	.insn	2, 0x4098
    37de:	0000                	.insn	2, 0x
    37e0:	52d8                	.insn	2, 0x52d8
    37e2:	0000                	.insn	2, 0x
    37e4:	52a8                	.insn	2, 0x52a8
    37e6:	0000                	.insn	2, 0x
    37e8:	52b0                	.insn	2, 0x52b0
    37ea:	0000                	.insn	2, 0x
    37ec:	52e0                	.insn	2, 0x52e0
    37ee:	0000                	.insn	2, 0x
    37f0:	4f6c                	.insn	2, 0x4f6c
    37f2:	0000                	.insn	2, 0x
    37f4:	4098                	.insn	2, 0x4098
    37f6:	0000                	.insn	2, 0x
    37f8:	4098                	.insn	2, 0x4098
    37fa:	0000                	.insn	2, 0x
    37fc:	52f8                	.insn	2, 0x52f8
    37fe:	0000                	.insn	2, 0x
    3800:	5300                	.insn	2, 0x5300
    3802:	0000                	.insn	2, 0x
    3804:	5308                	.insn	2, 0x5308
    3806:	0000                	.insn	2, 0x
    3808:	5310                	.insn	2, 0x5310
    380a:	0000                	.insn	2, 0x
    380c:	4f54                	.insn	2, 0x4f54
    380e:	0000                	.insn	2, 0x
    3810:	4fbc                	.insn	2, 0x4fbc
    3812:	0000                	.insn	2, 0x
    3814:	4098                	.insn	2, 0x4098
    3816:	0000                	.insn	2, 0x
    3818:	4098                	.insn	2, 0x4098
    381a:	0000                	.insn	2, 0x
    381c:	52c8                	.insn	2, 0x52c8
    381e:	0000                	.insn	2, 0x
    3820:	52d0                	.insn	2, 0x52d0
    3822:	0000                	.insn	2, 0x
    3824:	5404                	.insn	2, 0x5404
    3826:	0000                	.insn	2, 0x
    3828:	540c                	.insn	2, 0x540c
    382a:	0000                	.insn	2, 0x
    382c:	53e4                	.insn	2, 0x53e4
    382e:	0000                	.insn	2, 0x
    3830:	4fc4                	.insn	2, 0x4fc4
    3832:	0000                	.insn	2, 0x
    3834:	4098                	.insn	2, 0x4098
    3836:	0000                	.insn	2, 0x
    3838:	4098                	.insn	2, 0x4098
    383a:	0000                	.insn	2, 0x
    383c:	5250                	.insn	2, 0x5250
    383e:	0000                	.insn	2, 0x
    3840:	5258                	.insn	2, 0x5258
    3842:	0000                	.insn	2, 0x
    3844:	5248                	.insn	2, 0x5248
    3846:	0000                	.insn	2, 0x
    3848:	5268                	.insn	2, 0x5268
    384a:	0000                	.insn	2, 0x
    384c:	5260                	.insn	2, 0x5260
    384e:	0000                	.insn	2, 0x
    3850:	5298                	.insn	2, 0x5298
    3852:	0000                	.insn	2, 0x
    3854:	4098                	.insn	2, 0x4098
    3856:	0000                	.insn	2, 0x
    3858:	4098                	.insn	2, 0x4098
    385a:	0000                	.insn	2, 0x
    385c:	4098                	.insn	2, 0x4098
    385e:	0000                	.insn	2, 0x
    3860:	52a0                	.insn	2, 0x52a0
    3862:	0000                	.insn	2, 0x
    3864:	5414                	.insn	2, 0x5414
    3866:	0000                	.insn	2, 0x
    3868:	53ec                	.insn	2, 0x53ec
    386a:	0000                	.insn	2, 0x
    386c:	4f9c                	.insn	2, 0x4f9c
    386e:	0000                	.insn	2, 0x
    3870:	4fa4                	.insn	2, 0x4fa4
    3872:	0000                	.insn	2, 0x
    3874:	4098                	.insn	2, 0x4098
    3876:	0000                	.insn	2, 0x
    3878:	4098                	.insn	2, 0x4098
    387a:	0000                	.insn	2, 0x
    387c:	53f4                	.insn	2, 0x53f4
    387e:	0000                	.insn	2, 0x
    3880:	53a4                	.insn	2, 0x53a4
    3882:	0000                	.insn	2, 0x
    3884:	53ac                	.insn	2, 0x53ac
    3886:	0000                	.insn	2, 0x
    3888:	53fc                	.insn	2, 0x53fc
    388a:	0000                	.insn	2, 0x
    388c:	4fac                	.insn	2, 0x4fac
    388e:	0000                	.insn	2, 0x
    3890:	4fb4                	.insn	2, 0x4fb4
    3892:	0000                	.insn	2, 0x
    3894:	4098                	.insn	2, 0x4098
    3896:	0000                	.insn	2, 0x
    3898:	4098                	.insn	2, 0x4098
    389a:	0000                	.insn	2, 0x
    389c:	4f5c                	.insn	2, 0x4f5c
    389e:	0000                	.insn	2, 0x
    38a0:	53d4                	.insn	2, 0x53d4
    38a2:	0000                	.insn	2, 0x
    38a4:	53dc                	.insn	2, 0x53dc
    38a6:	0000                	.insn	2, 0x
    38a8:	4098                	.insn	2, 0x4098
    38aa:	0000                	.insn	2, 0x
    38ac:	53b4                	.insn	2, 0x53b4
    38ae:	0000                	.insn	2, 0x
    38b0:	4098                	.insn	2, 0x4098
    38b2:	0000                	.insn	2, 0x
    38b4:	4098                	.insn	2, 0x4098
    38b6:	0000                	.insn	2, 0x
    38b8:	4098                	.insn	2, 0x4098
    38ba:	0000                	.insn	2, 0x
    38bc:	4098                	.insn	2, 0x4098
    38be:	0000                	.insn	2, 0x
    38c0:	4098                	.insn	2, 0x4098
    38c2:	0000                	.insn	2, 0x
    38c4:	4098                	.insn	2, 0x4098
    38c6:	0000                	.insn	2, 0x
    38c8:	53bc                	.insn	2, 0x53bc
    38ca:	0000                	.insn	2, 0x
    38cc:	4098                	.insn	2, 0x4098
    38ce:	0000                	.insn	2, 0x
    38d0:	4098                	.insn	2, 0x4098
    38d2:	0000                	.insn	2, 0x
    38d4:	4098                	.insn	2, 0x4098
    38d6:	0000                	.insn	2, 0x
    38d8:	4098                	.insn	2, 0x4098
    38da:	0000                	.insn	2, 0x
    38dc:	4098                	.insn	2, 0x4098
    38de:	0000                	.insn	2, 0x
    38e0:	4098                	.insn	2, 0x4098
    38e2:	0000                	.insn	2, 0x
    38e4:	53c4                	.insn	2, 0x53c4
    38e6:	0000                	.insn	2, 0x
    38e8:	4098                	.insn	2, 0x4098
    38ea:	0000                	.insn	2, 0x
    38ec:	4098                	.insn	2, 0x4098
    38ee:	0000                	.insn	2, 0x
    38f0:	4098                	.insn	2, 0x4098
    38f2:	0000                	.insn	2, 0x
    38f4:	4098                	.insn	2, 0x4098
    38f6:	0000                	.insn	2, 0x
    38f8:	4098                	.insn	2, 0x4098
    38fa:	0000                	.insn	2, 0x
    38fc:	4098                	.insn	2, 0x4098
    38fe:	0000                	.insn	2, 0x
    3900:	4098                	.insn	2, 0x4098
    3902:	0000                	.insn	2, 0x
    3904:	4098                	.insn	2, 0x4098
    3906:	0000                	.insn	2, 0x
    3908:	4098                	.insn	2, 0x4098
    390a:	0000                	.insn	2, 0x
    390c:	4098                	.insn	2, 0x4098
    390e:	0000                	.insn	2, 0x
    3910:	4098                	.insn	2, 0x4098
    3912:	0000                	.insn	2, 0x
    3914:	4098                	.insn	2, 0x4098
    3916:	0000                	.insn	2, 0x
    3918:	4098                	.insn	2, 0x4098
    391a:	0000                	.insn	2, 0x
    391c:	4f64                	.insn	2, 0x4f64
    391e:	0000                	.insn	2, 0x
    3920:	4098                	.insn	2, 0x4098
    3922:	0000                	.insn	2, 0x
    3924:	4f54                	.insn	2, 0x4f54
    3926:	0000                	.insn	2, 0x
    3928:	4f9c                	.insn	2, 0x4f9c
    392a:	0000                	.insn	2, 0x
    392c:	4098                	.insn	2, 0x4098
    392e:	0000                	.insn	2, 0x
    3930:	4098                	.insn	2, 0x4098
    3932:	0000                	.insn	2, 0x
    3934:	4098                	.insn	2, 0x4098
    3936:	0000                	.insn	2, 0x
    3938:	4fac                	.insn	2, 0x4fac
    393a:	0000                	.insn	2, 0x
    393c:	4f5c                	.insn	2, 0x4f5c
    393e:	0000                	.insn	2, 0x
    3940:	4f6c                	.insn	2, 0x4f6c
    3942:	0000                	.insn	2, 0x
    3944:	4fc4                	.insn	2, 0x4fc4
    3946:	0000                	.insn	2, 0x
    3948:	53cc                	.insn	2, 0x53cc
    394a:	0000                	.insn	2, 0x
    394c:	4fa4                	.insn	2, 0x4fa4
    394e:	0000                	.insn	2, 0x
    3950:	4098                	.insn	2, 0x4098
    3952:	0000                	.insn	2, 0x
    3954:	4098                	.insn	2, 0x4098
    3956:	0000                	.insn	2, 0x
    3958:	4098                	.insn	2, 0x4098
    395a:	0000                	.insn	2, 0x
    395c:	52b8                	.insn	2, 0x52b8
    395e:	0000                	.insn	2, 0x
    3960:	4fbc                	.insn	2, 0x4fbc
    3962:	0000                	.insn	2, 0x
    3964:	52c0                	.insn	2, 0x52c0
    3966:	0000                	.insn	2, 0x
    3968:	52f0                	.insn	2, 0x52f0
    396a:	0000                	.insn	2, 0x
    396c:	4fb4                	.insn	2, 0x4fb4
    396e:	0000                	.insn	2, 0x
    3970:	4238                	.insn	2, 0x4238
    3972:	0000                	.insn	2, 0x
    3974:	4090                	.insn	2, 0x4090
    3976:	0000                	.insn	2, 0x
    3978:	4214                	.insn	2, 0x4214
    397a:	0000                	.insn	2, 0x
    397c:	41f8                	.insn	2, 0x41f8
    397e:	0000                	.insn	2, 0x
    3980:	4090                	.insn	2, 0x4090
    3982:	0000                	.insn	2, 0x
    3984:	4090                	.insn	2, 0x4090
    3986:	0000                	.insn	2, 0x
    3988:	4090                	.insn	2, 0x4090
    398a:	0000                	.insn	2, 0x
    398c:	4090                	.insn	2, 0x4090
    398e:	0000                	.insn	2, 0x
    3990:	41a4                	.insn	2, 0x41a4
    3992:	0000                	.insn	2, 0x
    3994:	4090                	.insn	2, 0x4090
    3996:	0000                	.insn	2, 0x
    3998:	4090                	.insn	2, 0x4090
    399a:	0000                	.insn	2, 0x
    399c:	4178                	.insn	2, 0x4178
    399e:	0000                	.insn	2, 0x
    39a0:	4e88                	.insn	2, 0x4e88
    39a2:	0000                	.insn	2, 0x
    39a4:	49c4                	.insn	2, 0x49c4
    39a6:	0000                	.insn	2, 0x
    39a8:	4098                	.insn	2, 0x4098
    39aa:	0000                	.insn	2, 0x
    39ac:	4098                	.insn	2, 0x4098
    39ae:	0000                	.insn	2, 0x
    39b0:	4098                	.insn	2, 0x4098
    39b2:	0000                	.insn	2, 0x
    39b4:	4e98                	.insn	2, 0x4e98
    39b6:	0000                	.insn	2, 0x
    39b8:	4e78                	.insn	2, 0x4e78
    39ba:	0000                	.insn	2, 0x
    39bc:	4e68                	.insn	2, 0x4e68
    39be:	0000                	.insn	2, 0x
    39c0:	4e58                	.insn	2, 0x4e58
    39c2:	0000                	.insn	2, 0x
    39c4:	4d40                	.insn	2, 0x4d40
    39c6:	0000                	.insn	2, 0x
    39c8:	4098                	.insn	2, 0x4098
    39ca:	0000                	.insn	2, 0x
    39cc:	4098                	.insn	2, 0x4098
    39ce:	0000                	.insn	2, 0x
    39d0:	4d98                	.insn	2, 0x4d98
    39d2:	0000                	.insn	2, 0x
    39d4:	4d88                	.insn	2, 0x4d88
    39d6:	0000                	.insn	2, 0x
    39d8:	4e38                	.insn	2, 0x4e38
    39da:	0000                	.insn	2, 0x
    39dc:	4e28                	.insn	2, 0x4e28
    39de:	0000                	.insn	2, 0x
    39e0:	4d20                	.insn	2, 0x4d20
    39e2:	0000                	.insn	2, 0x
    39e4:	4d48                	.insn	2, 0x4d48
    39e6:	0000                	.insn	2, 0x
    39e8:	4098                	.insn	2, 0x4098
    39ea:	0000                	.insn	2, 0x
    39ec:	4098                	.insn	2, 0x4098
    39ee:	0000                	.insn	2, 0x
    39f0:	4f10                	.insn	2, 0x4f10
    39f2:	0000                	.insn	2, 0x
    39f4:	4ee8                	.insn	2, 0x4ee8
    39f6:	0000                	.insn	2, 0x
    39f8:	4db8                	.insn	2, 0x4db8
    39fa:	0000                	.insn	2, 0x
    39fc:	4da8                	.insn	2, 0x4da8
    39fe:	0000                	.insn	2, 0x
    3a00:	4d58                	.insn	2, 0x4d58
    3a02:	0000                	.insn	2, 0x
    3a04:	4d38                	.insn	2, 0x4d38
    3a06:	0000                	.insn	2, 0x
    3a08:	4098                	.insn	2, 0x4098
    3a0a:	0000                	.insn	2, 0x
    3a0c:	4098                	.insn	2, 0x4098
    3a0e:	0000                	.insn	2, 0x
    3a10:	4eb8                	.insn	2, 0x4eb8
    3a12:	0000                	.insn	2, 0x
    3a14:	4ea8                	.insn	2, 0x4ea8
    3a16:	0000                	.insn	2, 0x
    3a18:	4d78                	.insn	2, 0x4d78
    3a1a:	0000                	.insn	2, 0x
    3a1c:	4d68                	.insn	2, 0x4d68
    3a1e:	0000                	.insn	2, 0x
    3a20:	4de8                	.insn	2, 0x4de8
    3a22:	0000                	.insn	2, 0x
    3a24:	4dd8                	.insn	2, 0x4dd8
    3a26:	0000                	.insn	2, 0x
    3a28:	4098                	.insn	2, 0x4098
    3a2a:	0000                	.insn	2, 0x
    3a2c:	4098                	.insn	2, 0x4098
    3a2e:	0000                	.insn	2, 0x
    3a30:	4098                	.insn	2, 0x4098
    3a32:	0000                	.insn	2, 0x
    3a34:	4dc8                	.insn	2, 0x4dc8
    3a36:	0000                	.insn	2, 0x
    3a38:	4ef8                	.insn	2, 0x4ef8
    3a3a:	0000                	.insn	2, 0x
    3a3c:	4ed8                	.insn	2, 0x4ed8
    3a3e:	0000                	.insn	2, 0x
    3a40:	4d30                	.insn	2, 0x4d30
    3a42:	0000                	.insn	2, 0x
    3a44:	4d28                	.insn	2, 0x4d28
    3a46:	0000                	.insn	2, 0x
    3a48:	4098                	.insn	2, 0x4098
    3a4a:	0000                	.insn	2, 0x
    3a4c:	4098                	.insn	2, 0x4098
    3a4e:	0000                	.insn	2, 0x
    3a50:	4f20                	.insn	2, 0x4f20
    3a52:	0000                	.insn	2, 0x
    3a54:	4e18                	.insn	2, 0x4e18
    3a56:	0000                	.insn	2, 0x
    3a58:	4e08                	.insn	2, 0x4e08
    3a5a:	0000                	.insn	2, 0x
    3a5c:	4e48                	.insn	2, 0x4e48
    3a5e:	0000                	.insn	2, 0x
    3a60:	4d50                	.insn	2, 0x4d50
    3a62:	0000                	.insn	2, 0x
    3a64:	4d10                	.insn	2, 0x4d10
    3a66:	0000                	.insn	2, 0x
    3a68:	4098                	.insn	2, 0x4098
    3a6a:	0000                	.insn	2, 0x
    3a6c:	4098                	.insn	2, 0x4098
    3a6e:	0000                	.insn	2, 0x
    3a70:	4d18                	.insn	2, 0x4d18
    3a72:	0000                	.insn	2, 0x
    3a74:	4f18                	.insn	2, 0x4f18
    3a76:	0000                	.insn	2, 0x
    3a78:	4df8                	.insn	2, 0x4df8
    3a7a:	0000                	.insn	2, 0x
    3a7c:	4098                	.insn	2, 0x4098
    3a7e:	0000                	.insn	2, 0x
    3a80:	4ec8                	.insn	2, 0x4ec8
    3a82:	0000                	.insn	2, 0x
    3a84:	4098                	.insn	2, 0x4098
    3a86:	0000                	.insn	2, 0x
    3a88:	4098                	.insn	2, 0x4098
    3a8a:	0000                	.insn	2, 0x
    3a8c:	4098                	.insn	2, 0x4098
    3a8e:	0000                	.insn	2, 0x
    3a90:	4098                	.insn	2, 0x4098
    3a92:	0000                	.insn	2, 0x
    3a94:	4098                	.insn	2, 0x4098
    3a96:	0000                	.insn	2, 0x
    3a98:	4098                	.insn	2, 0x4098
    3a9a:	0000                	.insn	2, 0x
    3a9c:	4f08                	.insn	2, 0x4f08
    3a9e:	0000                	.insn	2, 0x
    3aa0:	4098                	.insn	2, 0x4098
    3aa2:	0000                	.insn	2, 0x
    3aa4:	4098                	.insn	2, 0x4098
    3aa6:	0000                	.insn	2, 0x
    3aa8:	4098                	.insn	2, 0x4098
    3aaa:	0000                	.insn	2, 0x
    3aac:	4098                	.insn	2, 0x4098
    3aae:	0000                	.insn	2, 0x
    3ab0:	4098                	.insn	2, 0x4098
    3ab2:	0000                	.insn	2, 0x
    3ab4:	4098                	.insn	2, 0x4098
    3ab6:	0000                	.insn	2, 0x
    3ab8:	4f94                	.insn	2, 0x4f94
    3aba:	0000                	.insn	2, 0x
    3abc:	4098                	.insn	2, 0x4098
    3abe:	0000                	.insn	2, 0x
    3ac0:	4098                	.insn	2, 0x4098
    3ac2:	0000                	.insn	2, 0x
    3ac4:	4098                	.insn	2, 0x4098
    3ac6:	0000                	.insn	2, 0x
    3ac8:	4098                	.insn	2, 0x4098
    3aca:	0000                	.insn	2, 0x
    3acc:	4098                	.insn	2, 0x4098
    3ace:	0000                	.insn	2, 0x
    3ad0:	4098                	.insn	2, 0x4098
    3ad2:	0000                	.insn	2, 0x
    3ad4:	4098                	.insn	2, 0x4098
    3ad6:	0000                	.insn	2, 0x
    3ad8:	4098                	.insn	2, 0x4098
    3ada:	0000                	.insn	2, 0x
    3adc:	4098                	.insn	2, 0x4098
    3ade:	0000                	.insn	2, 0x
    3ae0:	4098                	.insn	2, 0x4098
    3ae2:	0000                	.insn	2, 0x
    3ae4:	4098                	.insn	2, 0x4098
    3ae6:	0000                	.insn	2, 0x
    3ae8:	4098                	.insn	2, 0x4098
    3aea:	0000                	.insn	2, 0x
    3aec:	4098                	.insn	2, 0x4098
    3aee:	0000                	.insn	2, 0x
    3af0:	49c4                	.insn	2, 0x49c4
    3af2:	0000                	.insn	2, 0x
    3af4:	4098                	.insn	2, 0x4098
    3af6:	0000                	.insn	2, 0x
    3af8:	4d20                	.insn	2, 0x4d20
    3afa:	0000                	.insn	2, 0x
    3afc:	4d30                	.insn	2, 0x4d30
    3afe:	0000                	.insn	2, 0x
    3b00:	4098                	.insn	2, 0x4098
    3b02:	0000                	.insn	2, 0x
    3b04:	4098                	.insn	2, 0x4098
    3b06:	0000                	.insn	2, 0x
    3b08:	4098                	.insn	2, 0x4098
    3b0a:	0000                	.insn	2, 0x
    3b0c:	4d50                	.insn	2, 0x4d50
    3b0e:	0000                	.insn	2, 0x
    3b10:	4d18                	.insn	2, 0x4d18
    3b12:	0000                	.insn	2, 0x
    3b14:	4d40                	.insn	2, 0x4d40
    3b16:	0000                	.insn	2, 0x
    3b18:	4d38                	.insn	2, 0x4d38
    3b1a:	0000                	.insn	2, 0x
    3b1c:	4f8c                	.insn	2, 0x4f8c
    3b1e:	0000                	.insn	2, 0x
    3b20:	4d28                	.insn	2, 0x4d28
    3b22:	0000                	.insn	2, 0x
    3b24:	4098                	.insn	2, 0x4098
    3b26:	0000                	.insn	2, 0x
    3b28:	4098                	.insn	2, 0x4098
    3b2a:	0000                	.insn	2, 0x
    3b2c:	4098                	.insn	2, 0x4098
    3b2e:	0000                	.insn	2, 0x
    3b30:	4f84                	.insn	2, 0x4f84
    3b32:	0000                	.insn	2, 0x
    3b34:	4d48                	.insn	2, 0x4d48
    3b36:	0000                	.insn	2, 0x
    3b38:	4f7c                	.insn	2, 0x4f7c
    3b3a:	0000                	.insn	2, 0x
    3b3c:	4f74                	.insn	2, 0x4f74
    3b3e:	0000                	.insn	2, 0x
    3b40:	4d10                	.insn	2, 0x4d10
	...

00003b44 <CSWTCH.180>:
    3b44:	0000 0000 0000 3f80 0000 4000 0000 4040     .......?...@..@@
    3b54:	0000 4080 0000 40a0 0000 40c0 0000 40e0     ...@...@...@...@
    3b64:	0000 4100                                   ...A

00003b68 <CSWTCH.200>:
    3b68:	cccd 3dcc d70a 3c23 126f 3a83 b717 38d1     ...=..#<o..:...8
    3b78:	c5ac 3727 37bd 3586                         ..'7.7.5

00003b80 <__clz_tab>:
    3b80:	0100 0202 0303 0303 0404 0404 0404 0404     ................
    3b90:	0505 0505 0505 0505 0505 0505 0505 0505     ................
    3ba0:	0606 0606 0606 0606 0606 0606 0606 0606     ................
    3bb0:	0606 0606 0606 0606 0606 0606 0606 0606     ................
    3bc0:	0707 0707 0707 0707 0707 0707 0707 0707     ................
    3bd0:	0707 0707 0707 0707 0707 0707 0707 0707     ................
    3be0:	0707 0707 0707 0707 0707 0707 0707 0707     ................
    3bf0:	0707 0707 0707 0707 0707 0707 0707 0707     ................
    3c00:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c10:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c20:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c30:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c40:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c50:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c60:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c70:	0808 0808 0808 0808 0808 0808 0808 0808     ................
    3c80:	0fdb 4049 f983 3e22 0000 3f00 0fdb c049     ..I@..">...?..I.
    3c90:	0fdb 40c9 d70a 3d23 1643 3d32 0c31 3d43     ...@..#=C.2=1.C=
    3ca0:	9436 3d57 f0f1 3d70 8889 3d88 89d9 3d9d     6.W=..p=...=...=
    3cb0:	2e8c 3dba 8e39 3de3 4925 3e12 cccd 3e4c     ...=9..=%I.>..L>
    3cc0:	aaab 3eaa 0000 3f80 13cd 3ed4 0fdb 3f49     ...>...?...>..I?
    3cd0:	0fdb 3fc9 0fdb bfc9 0000 bf80 1aa0 bf8f     ...?............
    3ce0:	5bd9 3ede 0000 4110 f854 402d 0000 4120     .[.>...AT.-@.. A
    3cf0:	37bd 3586 1aa0 3f8f                         .7.5...?

Disassembly of section .text.startup:

00003cf8 <main>:
    3cf8:	ee010113          	addi	x2,x2,-288
    3cfc:	000067b7          	lui	x15,0x6
    3d00:	11212823          	sw	x18,272(x2)
    3d04:	0f712e23          	sw	x23,252(x2)
    3d08:	aa078323          	sb	x0,-1370(x15) # 5aa6 <g_lshift_pressed>
    3d0c:	00006bb7          	lui	x23,0x6
    3d10:	000067b7          	lui	x15,0x6
    3d14:	00006937          	lui	x18,0x6
    3d18:	10112e23          	sw	x1,284(x2)
    3d1c:	aa0782a3          	sb	x0,-1371(x15) # 5aa5 <g_rshift_pressed>
    3d20:	10812c23          	sw	x8,280(x2)
    3d24:	10912a23          	sw	x9,276(x2)
    3d28:	10004437          	lui	x8,0x10004
    3d2c:	11412423          	sw	x20,264(x2)
    3d30:	11312623          	sw	x19,268(x2)
    3d34:	11512223          	sw	x21,260(x2)
    3d38:	11612023          	sw	x22,256(x2)
    3d3c:	0f812c23          	sw	x24,248(x2)
    3d40:	0f912a23          	sw	x25,244(x2)
    3d44:	0fa12823          	sw	x26,240(x2)
    3d48:	0fb12623          	sw	x27,236(x2)
    3d4c:	aa0b8423          	sb	x0,-1368(x23) # 5aa8 <g_prefix_f0>
    3d50:	aa0903a3          	sb	x0,-1369(x18) # 5aa7 <g_prefix_e0>
    3d54:	00042023          	sw	x0,0(x8) # 10004000 <_stack_ptr+0xfff4000>
    3d58:	00a00513          	addi	x10,x0,10
    3d5c:	ffffc097          	auipc	x1,0xffffc
    3d60:	2b8080e7          	jalr	x1,696(x1) # 14 <delay_ms>
    3d64:	00001737          	lui	x14,0x1
    3d68:	80070713          	addi	x14,x14,-2048 # 800 <parse_factor+0xc4>
    3d6c:	00e42023          	sw	x14,0(x8)
    3d70:	03200513          	addi	x10,x0,50
    3d74:	000014b7          	lui	x9,0x1
    3d78:	ffffc097          	auipc	x1,0xffffc
    3d7c:	29c080e7          	jalr	x1,668(x1) # 14 <delay_ms>
    3d80:	83048493          	addi	x9,x9,-2000 # 830 <parse_factor+0xf4>
    3d84:	00942023          	sw	x9,0(x8)
    3d88:	00048513          	addi	x10,x9,0
    3d8c:	ffffc097          	auipc	x1,0xffffc
    3d90:	2c4080e7          	jalr	x1,708(x1) # 50 <lcd_pulse_en>
    3d94:	00200513          	addi	x10,x0,2
    3d98:	ffffc097          	auipc	x1,0xffffc
    3d9c:	27c080e7          	jalr	x1,636(x1) # 14 <delay_ms>
    3da0:	00048513          	addi	x10,x9,0
    3da4:	00942023          	sw	x9,0(x8)
    3da8:	ffffc097          	auipc	x1,0xffffc
    3dac:	2a8080e7          	jalr	x1,680(x1) # 50 <lcd_pulse_en>
    3db0:	00200513          	addi	x10,x0,2
    3db4:	ffffc097          	auipc	x1,0xffffc
    3db8:	260080e7          	jalr	x1,608(x1) # 14 <delay_ms>
    3dbc:	00001537          	lui	x10,0x1
    3dc0:	80c50513          	addi	x10,x10,-2036 # 80c <parse_factor+0xd0>
    3dc4:	00a42023          	sw	x10,0(x8)
    3dc8:	ffffc097          	auipc	x1,0xffffc
    3dcc:	288080e7          	jalr	x1,648(x1) # 50 <lcd_pulse_en>
    3dd0:	00200513          	addi	x10,x0,2
    3dd4:	ffffc097          	auipc	x1,0xffffc
    3dd8:	240080e7          	jalr	x1,576(x1) # 14 <delay_ms>
    3ddc:	00001537          	lui	x10,0x1
    3de0:	80150513          	addi	x10,x10,-2047 # 801 <parse_factor+0xc5>
    3de4:	00a42023          	sw	x10,0(x8)
    3de8:	ffffc097          	auipc	x1,0xffffc
    3dec:	268080e7          	jalr	x1,616(x1) # 50 <lcd_pulse_en>
    3df0:	00300513          	addi	x10,x0,3
    3df4:	ffffc097          	auipc	x1,0xffffc
    3df8:	220080e7          	jalr	x1,544(x1) # 14 <delay_ms>
    3dfc:	00001537          	lui	x10,0x1
    3e00:	80650513          	addi	x10,x10,-2042 # 806 <parse_factor+0xca>
    3e04:	00a42023          	sw	x10,0(x8)
    3e08:	ffffc097          	auipc	x1,0xffffc
    3e0c:	248080e7          	jalr	x1,584(x1) # 50 <lcd_pulse_en>
    3e10:	00200513          	addi	x10,x0,2
    3e14:	ffffc097          	auipc	x1,0xffffc
    3e18:	200080e7          	jalr	x1,512(x1) # 14 <delay_ms>
    3e1c:	00005437          	lui	x8,0x5
    3e20:	202026b7          	lui	x13,0x20202
    3e24:	62840a13          	addi	x20,x8,1576 # 5628 <g_screen>
    3e28:	62840713          	addi	x14,x8,1576
    3e2c:	02068693          	addi	x13,x13,32 # 20202020 <_stack_ptr+0x201f2020>
    3e30:	000057b7          	lui	x15,0x5
    3e34:	00d72023          	sw	x13,0(x14)
    3e38:	00d72223          	sw	x13,4(x14)
    3e3c:	00d72423          	sw	x13,8(x14)
    3e40:	00d72623          	sw	x13,12(x14)
    3e44:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    3e48:	01070713          	addi	x14,x14,16
    3e4c:	fee792e3          	bne	x15,x14,3e30 <main+0x138>
    3e50:	000067b7          	lui	x15,0x6
    3e54:	aa078523          	sb	x0,-1366(x15) # 5aaa <g_expr_len>
    3e58:	000067b7          	lui	x15,0x6
    3e5c:	aa0784a3          	sb	x0,-1367(x15) # 5aa9 <g_cursor_pos>
    3e60:	060a0223          	sb	x0,100(x20)
    3e64:	040a0023          	sb	x0,64(x20)
    3e68:	ffffd097          	auipc	x1,0xffffd
    3e6c:	f24080e7          	jalr	x1,-220(x1) # d8c <lcd_clear>
    3e70:	62840593          	addi	x11,x8,1576
    3e74:	00000513          	addi	x10,x0,0
    3e78:	ffffc097          	auipc	x1,0xffffc
    3e7c:	584080e7          	jalr	x1,1412(x1) # 3fc <lcd_write_line_padded>
    3e80:	010a0593          	addi	x11,x20,16
    3e84:	00100513          	addi	x10,x0,1
    3e88:	ffffc097          	auipc	x1,0xffffc
    3e8c:	574080e7          	jalr	x1,1396(x1) # 3fc <lcd_write_line_padded>
    3e90:	020a0593          	addi	x11,x20,32
    3e94:	00200513          	addi	x10,x0,2
    3e98:	ffffc097          	auipc	x1,0xffffc
    3e9c:	564080e7          	jalr	x1,1380(x1) # 3fc <lcd_write_line_padded>
    3ea0:	030a0593          	addi	x11,x20,48
    3ea4:	00300513          	addi	x10,x0,3
    3ea8:	ffffc097          	auipc	x1,0xffffc
    3eac:	554080e7          	jalr	x1,1364(x1) # 3fc <lcd_write_line_padded>
    3eb0:	10000737          	lui	x14,0x10000
    3eb4:	00072023          	sw	x0,0(x14) # 10000000 <_stack_ptr+0xfff0000>
    3eb8:	10010737          	lui	x14,0x10010
    3ebc:	00072583          	lw	x11,0(x14) # 10010000 <_stack_ptr+0x10000000>
    3ec0:	00004737          	lui	x14,0x4
    3ec4:	97070713          	addi	x14,x14,-1680 # 3970 <__modsi3+0x20c>
    3ec8:	02e12023          	sw	x14,32(x2)
    3ecc:	00005737          	lui	x14,0x5
    3ed0:	68c70713          	addi	x14,x14,1676 # 568c <g_expr>
    3ed4:	02e12223          	sw	x14,36(x2)
    3ed8:	00003737          	lui	x14,0x3
    3edc:	7a470713          	addi	x14,x14,1956 # 37a4 <__modsi3+0x40>
    3ee0:	02e12e23          	sw	x14,60(x2)
    3ee4:	00005737          	lui	x14,0x5
    3ee8:	6a070713          	addi	x14,x14,1696 # 56a0 <g_gdram>
    3eec:	02e12a23          	sw	x14,52(x2)
    3ef0:	00003737          	lui	x14,0x3
    3ef4:	79470713          	addi	x14,x14,1940 # 3794 <__modsi3+0x30>
    3ef8:	02e12c23          	sw	x14,56(x2)
    3efc:	00003737          	lui	x14,0x3
    3f00:	79c70713          	addi	x14,x14,1948 # 379c <__modsi3+0x38>
    3f04:	02e12623          	sw	x14,44(x2)
    3f08:	00003737          	lui	x14,0x3
    3f0c:	7ac70713          	addi	x14,x14,1964 # 37ac <__modsi3+0x48>
    3f10:	04e12023          	sw	x14,64(x2)
    3f14:	00003737          	lui	x14,0x3
    3f18:	7b870713          	addi	x14,x14,1976 # 37b8 <__modsi3+0x54>
    3f1c:	04e12423          	sw	x14,72(x2)
    3f20:	00003737          	lui	x14,0x3
    3f24:	7b070713          	addi	x14,x14,1968 # 37b0 <__modsi3+0x4c>
    3f28:	04e12223          	sw	x14,68(x2)
    3f2c:	00003737          	lui	x14,0x3
    3f30:	7bc70713          	addi	x14,x14,1980 # 37bc <__modsi3+0x58>
    3f34:	000017b7          	lui	x15,0x1
    3f38:	c3478793          	addi	x15,x15,-972 # c34 <parse_expression+0x12c>
    3f3c:	000016b7          	lui	x13,0x1
    3f40:	04e12623          	sw	x14,76(x2)
    3f44:	00003737          	lui	x14,0x3
    3f48:	7c070713          	addi	x14,x14,1984 # 37c0 <__modsi3+0x5c>
    3f4c:	00001537          	lui	x10,0x1
    3f50:	00f12823          	sw	x15,16(x2)
    3f54:	83068793          	addi	x15,x13,-2000 # 830 <parse_factor+0xf4>
    3f58:	00001837          	lui	x16,0x1
    3f5c:	04e12823          	sw	x14,80(x2)
    3f60:	00f12223          	sw	x15,4(x2)
    3f64:	00004737          	lui	x14,0x4
    3f68:	c3050793          	addi	x15,x10,-976 # c30 <parse_expression+0x128>
    3f6c:	9a070713          	addi	x14,x14,-1632 # 39a0 <__modsi3+0x23c>
    3f70:	000018b7          	lui	x17,0x1
    3f74:	00f12a23          	sw	x15,20(x2)
    3f78:	80180793          	addi	x15,x16,-2047 # 801 <parse_factor+0xc5>
    3f7c:	00002337          	lui	x6,0x2
    3f80:	02e12423          	sw	x14,40(x2)
    3f84:	00f12423          	sw	x15,8(x2)
    3f88:	00003737          	lui	x14,0x3
    3f8c:	c0188793          	addi	x15,x17,-1023 # c01 <parse_expression+0xf9>
    3f90:	0095d613          	srli	x12,x11,0x9
    3f94:	00001c37          	lui	x24,0x1
    3f98:	7cc70713          	addi	x14,x14,1996 # 37cc <__modsi3+0x68>
    3f9c:	00f12c23          	sw	x15,24(x2)
    3fa0:	71030793          	addi	x15,x6,1808 # 2710 <__moddi3+0x1b4>
    3fa4:	0ff5f593          	andi	x11,x11,255
    3fa8:	00167613          	andi	x12,x12,1
    3fac:	00000a93          	addi	x21,x0,0
    3fb0:	00012623          	sw	x0,12(x2)
    3fb4:	00000b13          	addi	x22,x0,0
    3fb8:	00000c93          	addi	x25,x0,0
    3fbc:	00006d37          	lui	x26,0x6
    3fc0:	02e12823          	sw	x14,48(x2)
    3fc4:	10010db7          	lui	x27,0x10010
    3fc8:	834c0c13          	addi	x24,x24,-1996 # 834 <parse_factor+0xf8>
    3fcc:	00f12e23          	sw	x15,28(x2)
    3fd0:	000da783          	lw	x15,0(x27) # 10010000 <_stack_ptr+0x10000000>
    3fd4:	2007f493          	andi	x9,x15,512
    3fd8:	0ff7f413          	andi	x8,x15,255
    3fdc:	0c049a63          	bne	x9,x0,40b0 <main+0x3b8>
    3fe0:	0e858263          	beq	x11,x8,40c4 <main+0x3cc>
    3fe4:	aa8bc703          	lbu	x14,-1368(x23)
    3fe8:	aa794603          	lbu	x12,-1369(x18)
    3fec:	0ff7f793          	andi	x15,x15,255
    3ff0:	00a71693          	slli	x13,x14,0xa
    3ff4:	0167e7b3          	or	x15,x15,x22
    3ff8:	00d7e7b3          	or	x15,x15,x13
    3ffc:	00b61693          	slli	x13,x12,0xb
    4000:	00d7e7b3          	or	x15,x15,x13
    4004:	0197e7b3          	or	x15,x15,x25
    4008:	1007e793          	ori	x15,x15,256
    400c:	100006b7          	lui	x13,0x10000
    4010:	00f6a023          	sw	x15,0(x13) # 10000000 <_stack_ptr+0xfff0000>
    4014:	0e000793          	addi	x15,x0,224
    4018:	3af40a63          	beq	x8,x15,43cc <main+0x6d4>
    401c:	0f000793          	addi	x15,x0,240
    4020:	3cf40063          	beq	x8,x15,43e0 <main+0x6e8>
    4024:	aa0b8423          	sb	x0,-1368(x23)
    4028:	aa0903a3          	sb	x0,-1369(x18)
    402c:	0a061063          	bne	x12,x0,40cc <main+0x3d4>
    4030:	01200793          	addi	x15,x0,18
    4034:	3cf40063          	beq	x8,x15,43f4 <main+0x6fc>
    4038:	05900793          	addi	x15,x0,89
    403c:	3cf40a63          	beq	x8,x15,4410 <main+0x718>
    4040:	aa4d4783          	lbu	x15,-1372(x26) # 5aa4 <g_is_graphic_mode>
    4044:	20079c63          	bne	x15,x0,425c <main+0x564>
    4048:	12071263          	bne	x14,x0,416c <main+0x474>
    404c:	05a00793          	addi	x15,x0,90
    4050:	3ef40e63          	beq	x8,x15,444c <main+0x754>
    4054:	06600793          	addi	x15,x0,102
    4058:	4af40863          	beq	x8,x15,4508 <main+0x810>
    405c:	07600793          	addi	x15,x0,118
    4060:	50f40663          	beq	x8,x15,456c <main+0x874>
    4064:	00c12783          	lw	x15,12(x2)
    4068:	3c078063          	beq	x15,x0,4428 <main+0x730>
    406c:	feb40793          	addi	x15,x8,-21
    4070:	0ff7f793          	andi	x15,x15,255
    4074:	06800713          	addi	x14,x0,104
    4078:	02f76063          	bltu	x14,x15,4098 <main+0x3a0>
    407c:	03012703          	lw	x14,48(x2)
    4080:	00279793          	slli	x15,x15,0x2
    4084:	00f707b3          	add	x15,x14,x15
    4088:	0007a783          	lw	x15,0(x15)
    408c:	00078067          	jalr	x0,0(x15)
    4090:	04a00793          	addi	x15,x0,74
    4094:	06f40463          	beq	x8,x15,40fc <main+0x404>
    4098:	000da783          	lw	x15,0(x27)
    409c:	00040593          	addi	x11,x8,0
    40a0:	00000613          	addi	x12,x0,0
    40a4:	2007f493          	andi	x9,x15,512
    40a8:	0ff7f413          	andi	x8,x15,255
    40ac:	f2048ae3          	beq	x9,x0,3fe0 <main+0x2e8>
    40b0:	aa0b8423          	sb	x0,-1368(x23)
    40b4:	aa0903a3          	sb	x0,-1369(x18)
    40b8:	00040593          	addi	x11,x8,0
    40bc:	00100613          	addi	x12,x0,1
    40c0:	f11ff06f          	jal	x0,3fd0 <main+0x2d8>
    40c4:	f00606e3          	beq	x12,x0,3fd0 <main+0x2d8>
    40c8:	f1dff06f          	jal	x0,3fe4 <main+0x2ec>
    40cc:	aa4d4783          	lbu	x15,-1372(x26)
    40d0:	18079663          	bne	x15,x0,425c <main+0x564>
    40d4:	08071c63          	bne	x14,x0,416c <main+0x474>
    40d8:	f9740793          	addi	x15,x8,-105
    40dc:	0ff7f793          	andi	x15,x15,255
    40e0:	00b00713          	addi	x14,x0,11
    40e4:	faf766e3          	bltu	x14,x15,4090 <main+0x398>
    40e8:	02012703          	lw	x14,32(x2)
    40ec:	00279793          	slli	x15,x15,0x2
    40f0:	00f707b3          	add	x15,x14,x15
    40f4:	0007a783          	lw	x15,0(x15)
    40f8:	00078067          	jalr	x0,0(x15)
    40fc:	02f00713          	addi	x14,x0,47
    4100:	000067b7          	lui	x15,0x6
    4104:	aaa7c603          	lbu	x12,-1366(x15) # 5aaa <g_expr_len>
    4108:	00f00793          	addi	x15,x0,15
    410c:	06c7e063          	bltu	x15,x12,416c <main+0x474>
    4110:	000067b7          	lui	x15,0x6
    4114:	aa97c503          	lbu	x10,-1367(x15) # 5aa9 <g_cursor_pos>
    4118:	02412683          	lw	x13,36(x2)
    411c:	00c687b3          	add	x15,x13,x12
    4120:	00a685b3          	add	x11,x13,x10
    4124:	00c55a63          	bge	x10,x12,4138 <main+0x440>
    4128:	fff7c683          	lbu	x13,-1(x15)
    412c:	fff78793          	addi	x15,x15,-1
    4130:	00d780a3          	sb	x13,1(x15)
    4134:	feb79ae3          	bne	x15,x11,4128 <main+0x430>
    4138:	00aa06b3          	add	x13,x20,x10
    413c:	00160793          	addi	x15,x12,1
    4140:	0ff7f793          	andi	x15,x15,255
    4144:	06e68223          	sb	x14,100(x13)
    4148:	000066b7          	lui	x13,0x6
    414c:	00fa0733          	add	x14,x20,x15
    4150:	00150513          	addi	x10,x10,1
    4154:	aaf68523          	sb	x15,-1366(x13) # 5aaa <g_expr_len>
    4158:	000067b7          	lui	x15,0x6
    415c:	aaa784a3          	sb	x10,-1367(x15) # 5aa9 <g_cursor_pos>
    4160:	06070223          	sb	x0,100(x14)
    4164:	ffffc097          	auipc	x1,0xffffc
    4168:	4c0080e7          	jalr	x1,1216(x1) # 624 <input_refresh_row>
    416c:	00040593          	addi	x11,x8,0
    4170:	00000613          	addi	x12,x0,0
    4174:	e5dff06f          	jal	x0,3fd0 <main+0x2d8>
    4178:	000067b7          	lui	x15,0x6
    417c:	00006737          	lui	x14,0x6
    4180:	aa97c783          	lbu	x15,-1367(x15) # 5aa9 <g_cursor_pos>
    4184:	aaa74703          	lbu	x14,-1366(x14) # 5aaa <g_expr_len>
    4188:	f0e7f8e3          	bgeu	x15,x14,4098 <main+0x3a0>
    418c:	00178793          	addi	x15,x15,1
    4190:	00006737          	lui	x14,0x6
    4194:	aaf704a3          	sb	x15,-1367(x14) # 5aa9 <g_cursor_pos>
    4198:	ffffc097          	auipc	x1,0xffffc
    419c:	48c080e7          	jalr	x1,1164(x1) # 624 <input_refresh_row>
    41a0:	ef9ff06f          	jal	x0,4098 <main+0x3a0>
    41a4:	000067b7          	lui	x15,0x6
    41a8:	00006737          	lui	x14,0x6
    41ac:	aa97c783          	lbu	x15,-1367(x15) # 5aa9 <g_cursor_pos>
    41b0:	aaa74603          	lbu	x12,-1366(x14) # 5aaa <g_expr_len>
    41b4:	eec7f2e3          	bgeu	x15,x12,4098 <main+0x3a0>
    41b8:	02412703          	lw	x14,36(x2)
    41bc:	00f707b3          	add	x15,x14,x15
    41c0:	00c706b3          	add	x13,x14,x12
    41c4:	0017c703          	lbu	x14,1(x15)
    41c8:	00178793          	addi	x15,x15,1
    41cc:	fee78fa3          	sb	x14,-1(x15)
    41d0:	fed79ae3          	bne	x15,x13,41c4 <main+0x4cc>
    41d4:	fff60793          	addi	x15,x12,-1
    41d8:	0ff7f793          	andi	x15,x15,255
    41dc:	000066b7          	lui	x13,0x6
    41e0:	00fa0733          	add	x14,x20,x15
    41e4:	aaf68523          	sb	x15,-1366(x13) # 5aaa <g_expr_len>
    41e8:	06070223          	sb	x0,100(x14)
    41ec:	ffffc097          	auipc	x1,0xffffc
    41f0:	438080e7          	jalr	x1,1080(x1) # 624 <input_refresh_row>
    41f4:	ea5ff06f          	jal	x0,4098 <main+0x3a0>
    41f8:	000067b7          	lui	x15,0x6
    41fc:	aa0784a3          	sb	x0,-1367(x15) # 5aa9 <g_cursor_pos>
    4200:	ffffc097          	auipc	x1,0xffffc
    4204:	424080e7          	jalr	x1,1060(x1) # 624 <input_refresh_row>
    4208:	00000613          	addi	x12,x0,0
    420c:	00040593          	addi	x11,x8,0
    4210:	dc1ff06f          	jal	x0,3fd0 <main+0x2d8>
    4214:	000067b7          	lui	x15,0x6
    4218:	aa97c783          	lbu	x15,-1367(x15) # 5aa9 <g_cursor_pos>
    421c:	e6078ee3          	beq	x15,x0,4098 <main+0x3a0>
    4220:	fff78793          	addi	x15,x15,-1
    4224:	00006737          	lui	x14,0x6
    4228:	aaf704a3          	sb	x15,-1367(x14) # 5aa9 <g_cursor_pos>
    422c:	ffffc097          	auipc	x1,0xffffc
    4230:	3f8080e7          	jalr	x1,1016(x1) # 624 <input_refresh_row>
    4234:	e65ff06f          	jal	x0,4098 <main+0x3a0>
    4238:	000067b7          	lui	x15,0x6
    423c:	aaa7c783          	lbu	x15,-1366(x15) # 5aaa <g_expr_len>
    4240:	00006737          	lui	x14,0x6
    4244:	aaf704a3          	sb	x15,-1367(x14) # 5aa9 <g_cursor_pos>
    4248:	ffffc097          	auipc	x1,0xffffc
    424c:	3dc080e7          	jalr	x1,988(x1) # 624 <input_refresh_row>
    4250:	00000613          	addi	x12,x0,0
    4254:	00040593          	addi	x11,x8,0
    4258:	d79ff06f          	jal	x0,3fd0 <main+0x2d8>
    425c:	f00718e3          	bne	x14,x0,416c <main+0x474>
    4260:	01012703          	lw	x14,16(x2)
    4264:	100047b7          	lui	x15,0x10004
    4268:	aa0d0223          	sb	x0,-1372(x26)
    426c:	0187a023          	sw	x24,0(x15) # 10004000 <_stack_ptr+0xfff4000>
    4270:	00e7a023          	sw	x14,0(x15)
    4274:	00a00793          	addi	x15,x0,10
    4278:	08f12423          	sw	x15,136(x2)
    427c:	08812783          	lw	x15,136(x2)
    4280:	00f05c63          	bge	x0,x15,4298 <main+0x5a0>
    4284:	08812783          	lw	x15,136(x2)
    4288:	fff78793          	addi	x15,x15,-1
    428c:	08f12423          	sw	x15,136(x2)
    4290:	08812783          	lw	x15,136(x2)
    4294:	fef048e3          	blt	x0,x15,4284 <main+0x58c>
    4298:	100047b7          	lui	x15,0x10004
    429c:	0187a023          	sw	x24,0(x15) # 10004000 <_stack_ptr+0xfff4000>
    42a0:	16800793          	addi	x15,x0,360
    42a4:	08f12623          	sw	x15,140(x2)
    42a8:	08c12783          	lw	x15,140(x2)
    42ac:	00f05c63          	bge	x0,x15,42c4 <main+0x5cc>
    42b0:	08c12783          	lw	x15,140(x2)
    42b4:	fff78793          	addi	x15,x15,-1
    42b8:	08f12623          	sw	x15,140(x2)
    42bc:	08c12783          	lw	x15,140(x2)
    42c0:	fef048e3          	blt	x0,x15,42b0 <main+0x5b8>
    42c4:	00412703          	lw	x14,4(x2)
    42c8:	100047b7          	lui	x15,0x10004
    42cc:	00e7a023          	sw	x14,0(x15) # 10004000 <_stack_ptr+0xfff4000>
    42d0:	01412703          	lw	x14,20(x2)
    42d4:	00e7a023          	sw	x14,0(x15)
    42d8:	00a00793          	addi	x15,x0,10
    42dc:	08f12023          	sw	x15,128(x2)
    42e0:	08012783          	lw	x15,128(x2)
    42e4:	00f05c63          	bge	x0,x15,42fc <main+0x604>
    42e8:	08012783          	lw	x15,128(x2)
    42ec:	fff78793          	addi	x15,x15,-1
    42f0:	08f12023          	sw	x15,128(x2)
    42f4:	08012783          	lw	x15,128(x2)
    42f8:	fef048e3          	blt	x0,x15,42e8 <main+0x5f0>
    42fc:	00412703          	lw	x14,4(x2)
    4300:	100047b7          	lui	x15,0x10004
    4304:	00e7a023          	sw	x14,0(x15) # 10004000 <_stack_ptr+0xfff4000>
    4308:	16800793          	addi	x15,x0,360
    430c:	08f12223          	sw	x15,132(x2)
    4310:	08412783          	lw	x15,132(x2)
    4314:	00f05c63          	bge	x0,x15,432c <main+0x634>
    4318:	08412783          	lw	x15,132(x2)
    431c:	fff78793          	addi	x15,x15,-1
    4320:	08f12223          	sw	x15,132(x2)
    4324:	08412783          	lw	x15,132(x2)
    4328:	fef048e3          	blt	x0,x15,4318 <main+0x620>
    432c:	00812703          	lw	x14,8(x2)
    4330:	100047b7          	lui	x15,0x10004
    4334:	00e7a023          	sw	x14,0(x15) # 10004000 <_stack_ptr+0xfff4000>
    4338:	01812703          	lw	x14,24(x2)
    433c:	00e7a023          	sw	x14,0(x15)
    4340:	00a00793          	addi	x15,x0,10
    4344:	08f12823          	sw	x15,144(x2)
    4348:	09012783          	lw	x15,144(x2)
    434c:	00f05c63          	bge	x0,x15,4364 <main+0x66c>
    4350:	09012783          	lw	x15,144(x2)
    4354:	fff78793          	addi	x15,x15,-1
    4358:	08f12823          	sw	x15,144(x2)
    435c:	09012783          	lw	x15,144(x2)
    4360:	fef048e3          	blt	x0,x15,4350 <main+0x658>
    4364:	00812703          	lw	x14,8(x2)
    4368:	100047b7          	lui	x15,0x10004
    436c:	00e7a023          	sw	x14,0(x15) # 10004000 <_stack_ptr+0xfff4000>
    4370:	16800793          	addi	x15,x0,360
    4374:	08f12a23          	sw	x15,148(x2)
    4378:	09412783          	lw	x15,148(x2)
    437c:	00f05c63          	bge	x0,x15,4394 <main+0x69c>
    4380:	09412783          	lw	x15,148(x2)
    4384:	fff78793          	addi	x15,x15,-1
    4388:	08f12a23          	sw	x15,148(x2)
    438c:	09412783          	lw	x15,148(x2)
    4390:	fef048e3          	blt	x0,x15,4380 <main+0x688>
    4394:	01c12783          	lw	x15,28(x2)
    4398:	06f12e23          	sw	x15,124(x2)
    439c:	07c12783          	lw	x15,124(x2)
    43a0:	00f05c63          	bge	x0,x15,43b8 <main+0x6c0>
    43a4:	07c12783          	lw	x15,124(x2)
    43a8:	fff78793          	addi	x15,x15,-1
    43ac:	06f12e23          	sw	x15,124(x2)
    43b0:	07c12783          	lw	x15,124(x2)
    43b4:	fef048e3          	blt	x0,x15,43a4 <main+0x6ac>
    43b8:	ffffc097          	auipc	x1,0xffffc
    43bc:	26c080e7          	jalr	x1,620(x1) # 624 <input_refresh_row>
    43c0:	ffffc097          	auipc	x1,0xffffc
    43c4:	164080e7          	jalr	x1,356(x1) # 524 <result_refresh_row>
    43c8:	da5ff06f          	jal	x0,416c <main+0x474>
    43cc:	00100793          	addi	x15,x0,1
    43d0:	aaf903a3          	sb	x15,-1369(x18)
    43d4:	0e000593          	addi	x11,x0,224
    43d8:	00000613          	addi	x12,x0,0
    43dc:	bf5ff06f          	jal	x0,3fd0 <main+0x2d8>
    43e0:	00100793          	addi	x15,x0,1
    43e4:	aafb8423          	sb	x15,-1368(x23)
    43e8:	0f000593          	addi	x11,x0,240
    43ec:	00000613          	addi	x12,x0,0
    43f0:	be1ff06f          	jal	x0,3fd0 <main+0x2d8>
    43f4:	00173793          	sltiu	x15,x14,1
    43f8:	00006737          	lui	x14,0x6
    43fc:	00f12623          	sw	x15,12(x2)
    4400:	aaf70323          	sb	x15,-1370(x14) # 5aa6 <g_lshift_pressed>
    4404:	01200593          	addi	x11,x0,18
    4408:	00c79b13          	slli	x22,x15,0xc
    440c:	bc5ff06f          	jal	x0,3fd0 <main+0x2d8>
    4410:	00173a93          	sltiu	x21,x14,1
    4414:	000067b7          	lui	x15,0x6
    4418:	ab5782a3          	sb	x21,-1371(x15) # 5aa5 <g_rshift_pressed>
    441c:	05900593          	addi	x11,x0,89
    4420:	00da9c93          	slli	x25,x21,0xd
    4424:	badff06f          	jal	x0,3fd0 <main+0x2d8>
    4428:	feb40793          	addi	x15,x8,-21
    442c:	0ff7f793          	andi	x15,x15,255
    4430:	06800713          	addi	x14,x0,104
    4434:	c6f762e3          	bltu	x14,x15,4098 <main+0x3a0>
    4438:	02812703          	lw	x14,40(x2)
    443c:	00279793          	slli	x15,x15,0x2
    4440:	00f707b3          	add	x15,x14,x15
    4444:	0007a783          	lw	x15,0(x15)
    4448:	00078067          	jalr	x0,0(x15)
    444c:	000067b7          	lui	x15,0x6
    4450:	aaa7c783          	lbu	x15,-1366(x15) # 5aaa <g_expr_len>
    4454:	16078663          	beq	x15,x0,45c0 <main+0x8c8>
    4458:	00700713          	addi	x14,x0,7
    445c:	064a4683          	lbu	x13,100(x20)
    4460:	00f77c63          	bgeu	x14,x15,4478 <main+0x780>
    4464:	06700713          	addi	x14,x0,103
    4468:	00e69863          	bne	x13,x14,4478 <main+0x780>
    446c:	065a4683          	lbu	x13,101(x20)
    4470:	07200713          	addi	x14,x0,114
    4474:	54e68c63          	beq	x13,x14,49cc <main+0xcd4>
    4478:	02412703          	lw	x14,36(x2)
    447c:	040a0023          	sb	x0,64(x20)
    4480:	05a00693          	addi	x13,x0,90
    4484:	00074783          	lbu	x15,0(x14)
    4488:	16078663          	beq	x15,x0,45f4 <main+0x8fc>
    448c:	10f6ea63          	bltu	x13,x15,45a0 <main+0x8a8>
    4490:	04000613          	addi	x12,x0,64
    4494:	00f66e63          	bltu	x12,x15,44b0 <main+0x7b8>
    4498:	02c00613          	addi	x12,x0,44
    449c:	00c78a63          	beq	x15,x12,44b0 <main+0x7b8>
    44a0:	fd278793          	addi	x15,x15,-46
    44a4:	0ff7f793          	andi	x15,x15,255
    44a8:	00100613          	addi	x12,x0,1
    44ac:	10f66663          	bltu	x12,x15,45b8 <main+0x8c0>
    44b0:	02412783          	lw	x15,36(x2)
    44b4:	0c810513          	addi	x10,x2,200
    44b8:	0c011623          	sh	x0,204(x2)
    44bc:	0cf12423          	sw	x15,200(x2)
    44c0:	0c010723          	sb	x0,206(x2)
    44c4:	ffffe097          	auipc	x1,0xffffe
    44c8:	86c080e7          	jalr	x1,-1940(x1) # 1d30 <f_parse_expression>
    44cc:	e00505d3          	fmv.x.w	x11,f10
    44d0:	00800637          	lui	x12,0x800
    44d4:	01700513          	addi	x10,x0,23
    44d8:	01360613          	addi	x12,x12,19 # 800013 <_stack_ptr+0x7f0013>
    44dc:	0c812683          	lw	x13,200(x2)
    44e0:	0006c703          	lbu	x14,0(x13)
    44e4:	ff770793          	addi	x15,x14,-9
    44e8:	0ff7f793          	andi	x15,x15,255
    44ec:	14f56663          	bltu	x10,x15,4638 <main+0x940>
    44f0:	00f657b3          	srl	x15,x12,x15
    44f4:	0017f793          	andi	x15,x15,1
    44f8:	44078263          	beq	x15,x0,493c <main+0xc44>
    44fc:	00168693          	addi	x13,x13,1
    4500:	0cd12423          	sw	x13,200(x2)
    4504:	fd9ff06f          	jal	x0,44dc <main+0x7e4>
    4508:	000067b7          	lui	x15,0x6
    450c:	aa97c583          	lbu	x11,-1367(x15) # 5aa9 <g_cursor_pos>
    4510:	b80584e3          	beq	x11,x0,4098 <main+0x3a0>
    4514:	000067b7          	lui	x15,0x6
    4518:	aaa7c603          	lbu	x12,-1366(x15) # 5aaa <g_expr_len>
    451c:	02412703          	lw	x14,36(x2)
    4520:	00b707b3          	add	x15,x14,x11
    4524:	00c706b3          	add	x13,x14,x12
    4528:	00c5fa63          	bgeu	x11,x12,453c <main+0x844>
    452c:	0007c703          	lbu	x14,0(x15)
    4530:	00178793          	addi	x15,x15,1
    4534:	fee78f23          	sb	x14,-2(x15)
    4538:	fed79ae3          	bne	x15,x13,452c <main+0x834>
    453c:	fff60793          	addi	x15,x12,-1
    4540:	0ff7f793          	andi	x15,x15,255
    4544:	000066b7          	lui	x13,0x6
    4548:	00fa0733          	add	x14,x20,x15
    454c:	aaf68523          	sb	x15,-1366(x13) # 5aaa <g_expr_len>
    4550:	fff58593          	addi	x11,x11,-1
    4554:	000067b7          	lui	x15,0x6
    4558:	aab784a3          	sb	x11,-1367(x15) # 5aa9 <g_cursor_pos>
    455c:	06070223          	sb	x0,100(x14)
    4560:	ffffc097          	auipc	x1,0xffffc
    4564:	0c4080e7          	jalr	x1,196(x1) # 624 <input_refresh_row>
    4568:	b31ff06f          	jal	x0,4098 <main+0x3a0>
    456c:	000067b7          	lui	x15,0x6
    4570:	aa078523          	sb	x0,-1366(x15) # 5aaa <g_expr_len>
    4574:	000067b7          	lui	x15,0x6
    4578:	aa0784a3          	sb	x0,-1367(x15) # 5aa9 <g_cursor_pos>
    457c:	060a0223          	sb	x0,100(x20)
    4580:	040a0023          	sb	x0,64(x20)
    4584:	ffffc097          	auipc	x1,0xffffc
    4588:	0a0080e7          	jalr	x1,160(x1) # 624 <input_refresh_row>
    458c:	ffffc097          	auipc	x1,0xffffc
    4590:	f98080e7          	jalr	x1,-104(x1) # 524 <result_refresh_row>
    4594:	00000613          	addi	x12,x0,0
    4598:	00040593          	addi	x11,x8,0
    459c:	a35ff06f          	jal	x0,3fd0 <main+0x2d8>
    45a0:	05e00613          	addi	x12,x0,94
    45a4:	f0c786e3          	beq	x15,x12,44b0 <main+0x7b8>
    45a8:	f9f78793          	addi	x15,x15,-97
    45ac:	0ff7f793          	andi	x15,x15,255
    45b0:	01900613          	addi	x12,x0,25
    45b4:	eef67ee3          	bgeu	x12,x15,44b0 <main+0x7b8>
    45b8:	00170713          	addi	x14,x14,1
    45bc:	ec9ff06f          	jal	x0,4484 <main+0x78c>
    45c0:	03c12703          	lw	x14,60(x2)
    45c4:	000057b7          	lui	x15,0x5
    45c8:	04500693          	addi	x13,x0,69
    45cc:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    45d0:	00170713          	addi	x14,x14,1
    45d4:	00d78023          	sb	x13,0(x15)
    45d8:	00074683          	lbu	x13,0(x14)
    45dc:	00178793          	addi	x15,x15,1
    45e0:	fe0698e3          	bne	x13,x0,45d0 <main+0x8d8>
    45e4:	00078023          	sb	x0,0(x15)
    45e8:	ffffc097          	auipc	x1,0xffffc
    45ec:	f3c080e7          	jalr	x1,-196(x1) # 524 <result_refresh_row>
    45f0:	aa9ff06f          	jal	x0,4098 <main+0x3a0>
    45f4:	02412503          	lw	x10,36(x2)
    45f8:	0b010593          	addi	x11,x2,176
    45fc:	04f12a23          	sw	x15,84(x2)
    4600:	ffffc097          	auipc	x1,0xffffc
    4604:	638080e7          	jalr	x1,1592(x1) # c38 <eval_expression>
    4608:	05412783          	lw	x15,84(x2)
    460c:	1c0510e3          	bne	x10,x0,4fcc <main+0x12d4>
    4610:	02c12703          	lw	x14,44(x2)
    4614:	000057b7          	lui	x15,0x5
    4618:	04500693          	addi	x13,x0,69
    461c:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    4620:	00170713          	addi	x14,x14,1
    4624:	00d78023          	sb	x13,0(x15)
    4628:	00074683          	lbu	x13,0(x14)
    462c:	00178793          	addi	x15,x15,1
    4630:	fe0698e3          	bne	x13,x0,4620 <main+0x928>
    4634:	fb1ff06f          	jal	x0,45e4 <main+0x8ec>
    4638:	0cc14783          	lbu	x15,204(x2)
    463c:	00f76733          	or	x14,x14,x15
    4640:	2e071e63          	bne	x14,x0,493c <main+0xc44>
    4644:	0175d813          	srli	x16,x11,0x17
    4648:	00800537          	lui	x10,0x800
    464c:	fff50713          	addi	x14,x10,-1 # 7fffff <_stack_ptr+0x7effff>
    4650:	0ff87993          	andi	x19,x16,255
    4654:	0ff00693          	addi	x13,x0,255
    4658:	01f5d793          	srli	x15,x11,0x1f
    465c:	00b77733          	and	x14,x14,x11
    4660:	0cd984e3          	beq	x19,x13,4f28 <main+0x1230>
    4664:	00159593          	slli	x11,x11,0x1
    4668:	380586e3          	beq	x11,x0,51f4 <main+0x14fc>
    466c:	2a0994e3          	bne	x19,x0,5114 <main+0x141c>
    4670:	040a0023          	sb	x0,64(x20)
    4674:	00000713          	addi	x14,x0,0
    4678:	280784e3          	beq	x15,x0,5100 <main+0x1408>
    467c:	00000993          	addi	x19,x0,0
    4680:	00000893          	addi	x17,x0,0
    4684:	00000313          	addi	x6,x0,0
    4688:	00000713          	addi	x14,x0,0
    468c:	00000813          	addi	x16,x0,0
    4690:	02d00793          	addi	x15,x0,45
    4694:	04fa1023          	sh	x15,64(x20)
    4698:	00100793          	addi	x15,x0,1
    469c:	240808e3          	beq	x16,x0,50ec <main+0x13f4>
    46a0:	0c810813          	addi	x16,x2,200
    46a4:	00000713          	addi	x14,x0,0
    46a8:	05312a23          	sw	x19,84(x2)
    46ac:	05512c23          	sw	x21,88(x2)
    46b0:	05912e23          	sw	x25,92(x2)
    46b4:	07812223          	sw	x24,100(x2)
    46b8:	00048c93          	addi	x25,x9,0
    46bc:	00040c13          	addi	x24,x8,0
    46c0:	00070a93          	addi	x21,x14,0
    46c4:	00080993          	addi	x19,x16,0
    46c8:	07612023          	sw	x22,96(x2)
    46cc:	00088413          	addi	x8,x17,0
    46d0:	00030493          	addi	x9,x6,0
    46d4:	00a00613          	addi	x12,x0,10
    46d8:	00000693          	addi	x13,x0,0
    46dc:	00040513          	addi	x10,x8,0
    46e0:	00048593          	addi	x11,x9,0
    46e4:	06f12623          	sw	x15,108(x2)
    46e8:	fffff097          	auipc	x1,0xfffff
    46ec:	a18080e7          	jalr	x1,-1512(x1) # 3100 <__umoddi3>
    46f0:	03050893          	addi	x17,x10,48
    46f4:	00048593          	addi	x11,x9,0
    46f8:	00040513          	addi	x10,x8,0
    46fc:	01198023          	sb	x17,0(x19)
    4700:	00a00613          	addi	x12,x0,10
    4704:	00000693          	addi	x13,x0,0
    4708:	06912423          	sw	x9,104(x2)
    470c:	ffffe097          	auipc	x1,0xffffe
    4710:	3c0080e7          	jalr	x1,960(x1) # 2acc <__udivdi3>
    4714:	06812703          	lw	x14,104(x2)
    4718:	00040b13          	addi	x22,x8,0
    471c:	06c12783          	lw	x15,108(x2)
    4720:	001a8a93          	addi	x21,x21,1
    4724:	00050413          	addi	x8,x10,0
    4728:	00058493          	addi	x9,x11,0
    472c:	00198993          	addi	x19,x19,1
    4730:	fa0712e3          	bne	x14,x0,46d4 <main+0x9dc>
    4734:	00900713          	addi	x14,x0,9
    4738:	f9676ee3          	bltu	x14,x22,46d4 <main+0x9dc>
    473c:	000a8713          	addi	x14,x21,0
    4740:	000c0413          	addi	x8,x24,0
    4744:	000c8493          	addi	x9,x25,0
    4748:	05412983          	lw	x19,84(x2)
    474c:	05812a83          	lw	x21,88(x2)
    4750:	05c12c83          	lw	x25,92(x2)
    4754:	06012b03          	lw	x22,96(x2)
    4758:	06412c03          	lw	x24,100(x2)
    475c:	00070693          	addi	x13,x14,0
    4760:	0b010613          	addi	x12,x2,176
    4764:	fff68693          	addi	x13,x13,-1
    4768:	0c810593          	addi	x11,x2,200
    476c:	00d585b3          	add	x11,x11,x13
    4770:	0005c583          	lbu	x11,0(x11)
    4774:	00160613          	addi	x12,x12,1
    4778:	feb60fa3          	sb	x11,-1(x12)
    477c:	fe0694e3          	bne	x13,x0,4764 <main+0xa6c>
    4780:	07070713          	addi	x14,x14,112
    4784:	07010693          	addi	x13,x2,112
    4788:	00d70733          	add	x14,x14,x13
    478c:	fc070823          	sb	x0,-48(x14)
    4790:	00005737          	lui	x14,0x5
    4794:	66870713          	addi	x14,x14,1640 # 5668 <g_result>
    4798:	00f707b3          	add	x15,x14,x15
    479c:	0b010713          	addi	x14,x2,176
    47a0:	0100006f          	jal	x0,47b0 <main+0xab8>
    47a4:	00178793          	addi	x15,x15,1
    47a8:	00170713          	addi	x14,x14,1
    47ac:	fed78fa3          	sb	x13,-1(x15)
    47b0:	00074683          	lbu	x13,0(x14)
    47b4:	fe0698e3          	bne	x13,x0,47a4 <main+0xaac>
    47b8:	00078023          	sb	x0,0(x15)
    47bc:	000057b7          	lui	x15,0x5
    47c0:	66878713          	addi	x14,x15,1640 # 5668 <g_result>
    47c4:	00000793          	addi	x15,x0,0
    47c8:	00c0006f          	jal	x0,47d4 <main+0xadc>
    47cc:	00178793          	addi	x15,x15,1
    47d0:	00060713          	addi	x14,x12,0
    47d4:	00074683          	lbu	x13,0(x14)
    47d8:	00170613          	addi	x12,x14,1
    47dc:	fe0698e3          	bne	x13,x0,47cc <main+0xad4>
    47e0:	e00984e3          	beq	x19,x0,45e8 <main+0x8f0>
    47e4:	02e00693          	addi	x13,x0,46
    47e8:	00d70023          	sb	x13,0(x14)
    47ec:	00005737          	lui	x14,0x5
    47f0:	66870713          	addi	x14,x14,1640 # 5668 <g_result>
    47f4:	00178793          	addi	x15,x15,1
    47f8:	00f707b3          	add	x15,x14,x15
    47fc:	000185b7          	lui	x11,0x18
    4800:	00078023          	sb	x0,0(x15)
    4804:	6a058593          	addi	x11,x11,1696 # 186a0 <_stack_ptr+0x86a0>
    4808:	00098513          	addi	x10,x19,0
    480c:	04f12a23          	sw	x15,84(x2)
    4810:	fffff097          	auipc	x1,0xfffff
    4814:	ed8080e7          	jalr	x1,-296(x1) # 36e8 <__hidden___udivsi3>
    4818:	000025b7          	lui	x11,0x2
    481c:	03050713          	addi	x14,x10,48
    4820:	71058593          	addi	x11,x11,1808 # 2710 <__moddi3+0x1b4>
    4824:	00098513          	addi	x10,x19,0
    4828:	0ce10423          	sb	x14,200(x2)
    482c:	fffff097          	auipc	x1,0xfffff
    4830:	ebc080e7          	jalr	x1,-324(x1) # 36e8 <__hidden___udivsi3>
    4834:	00a00593          	addi	x11,x0,10
    4838:	fffff097          	auipc	x1,0xfffff
    483c:	ef8080e7          	jalr	x1,-264(x1) # 3730 <__umodsi3>
    4840:	03050713          	addi	x14,x10,48
    4844:	3e800593          	addi	x11,x0,1000
    4848:	00098513          	addi	x10,x19,0
    484c:	0ce104a3          	sb	x14,201(x2)
    4850:	fffff097          	auipc	x1,0xfffff
    4854:	e98080e7          	jalr	x1,-360(x1) # 36e8 <__hidden___udivsi3>
    4858:	00a00593          	addi	x11,x0,10
    485c:	fffff097          	auipc	x1,0xfffff
    4860:	ed4080e7          	jalr	x1,-300(x1) # 3730 <__umodsi3>
    4864:	03050713          	addi	x14,x10,48
    4868:	06400593          	addi	x11,x0,100
    486c:	00098513          	addi	x10,x19,0
    4870:	0ce10523          	sb	x14,202(x2)
    4874:	fffff097          	auipc	x1,0xfffff
    4878:	e74080e7          	jalr	x1,-396(x1) # 36e8 <__hidden___udivsi3>
    487c:	00a00593          	addi	x11,x0,10
    4880:	fffff097          	auipc	x1,0xfffff
    4884:	eb0080e7          	jalr	x1,-336(x1) # 3730 <__umodsi3>
    4888:	03050713          	addi	x14,x10,48
    488c:	00a00593          	addi	x11,x0,10
    4890:	00098513          	addi	x10,x19,0
    4894:	0ce105a3          	sb	x14,203(x2)
    4898:	fffff097          	auipc	x1,0xfffff
    489c:	e50080e7          	jalr	x1,-432(x1) # 36e8 <__hidden___udivsi3>
    48a0:	00a00593          	addi	x11,x0,10
    48a4:	fffff097          	auipc	x1,0xfffff
    48a8:	e8c080e7          	jalr	x1,-372(x1) # 3730 <__umodsi3>
    48ac:	03050713          	addi	x14,x10,48
    48b0:	00a00593          	addi	x11,x0,10
    48b4:	00098513          	addi	x10,x19,0
    48b8:	0ff77993          	andi	x19,x14,255
    48bc:	fffff097          	auipc	x1,0xfffff
    48c0:	e74080e7          	jalr	x1,-396(x1) # 3730 <__umodsi3>
    48c4:	03050713          	addi	x14,x10,48
    48c8:	0ff77713          	andi	x14,x14,255
    48cc:	00871713          	slli	x14,x14,0x8
    48d0:	00e9e9b3          	or	x19,x19,x14
    48d4:	05412783          	lw	x15,84(x2)
    48d8:	0d311623          	sh	x19,204(x2)
    48dc:	0c010723          	sb	x0,206(x2)
    48e0:	0c810713          	addi	x14,x2,200
    48e4:	0100006f          	jal	x0,48f4 <main+0xbfc>
    48e8:	00178793          	addi	x15,x15,1
    48ec:	00170713          	addi	x14,x14,1
    48f0:	fed78fa3          	sb	x13,-1(x15)
    48f4:	00074683          	lbu	x13,0(x14)
    48f8:	fe0698e3          	bne	x13,x0,48e8 <main+0xbf0>
    48fc:	00078023          	sb	x0,0(x15)
    4900:	0080006f          	jal	x0,4908 <main+0xc10>
    4904:	00148493          	addi	x9,x9,1
    4908:	000057b7          	lui	x15,0x5
    490c:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    4910:	009787b3          	add	x15,x15,x9
    4914:	0007c703          	lbu	x14,0(x15)
    4918:	fe0716e3          	bne	x14,x0,4904 <main+0xc0c>
    491c:	03000713          	addi	x14,x0,48
    4920:	cc9054e3          	bge	x0,x9,45e8 <main+0x8f0>
    4924:	fff7c683          	lbu	x13,-1(x15)
    4928:	fff78793          	addi	x15,x15,-1
    492c:	7ae69063          	bne	x13,x14,50cc <main+0x13d4>
    4930:	00078023          	sb	x0,0(x15)
    4934:	fff48493          	addi	x9,x9,-1
    4938:	fe9ff06f          	jal	x0,4920 <main+0xc28>
    493c:	0cd14783          	lbu	x15,205(x2)
    4940:	04079e63          	bne	x15,x0,499c <main+0xca4>
    4944:	0ce14783          	lbu	x15,206(x2)
    4948:	02c12703          	lw	x14,44(x2)
    494c:	74079863          	bne	x15,x0,509c <main+0x13a4>
    4950:	000057b7          	lui	x15,0x5
    4954:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    4958:	0100006f          	jal	x0,4968 <main+0xc70>
    495c:	00178793          	addi	x15,x15,1
    4960:	00170713          	addi	x14,x14,1
    4964:	fed78fa3          	sb	x13,-1(x15)
    4968:	00074683          	lbu	x13,0(x14)
    496c:	fe0698e3          	bne	x13,x0,495c <main+0xc64>
    4970:	00078023          	sb	x0,0(x15)
    4974:	02c12703          	lw	x14,44(x2)
    4978:	000057b7          	lui	x15,0x5
    497c:	04500693          	addi	x13,x0,69
    4980:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    4984:	00170713          	addi	x14,x14,1
    4988:	00d78023          	sb	x13,0(x15)
    498c:	00074683          	lbu	x13,0(x14)
    4990:	00178793          	addi	x15,x15,1
    4994:	fe0698e3          	bne	x13,x0,4984 <main+0xc8c>
    4998:	c4dff06f          	jal	x0,45e4 <main+0x8ec>
    499c:	000057b7          	lui	x15,0x5
    49a0:	03812703          	lw	x14,56(x2)
    49a4:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    49a8:	0100006f          	jal	x0,49b8 <main+0xcc0>
    49ac:	00178793          	addi	x15,x15,1
    49b0:	00170713          	addi	x14,x14,1
    49b4:	fed78fa3          	sb	x13,-1(x15)
    49b8:	00074683          	lbu	x13,0(x14)
    49bc:	fe0698e3          	bne	x13,x0,49ac <main+0xcb4>
    49c0:	fb1ff06f          	jal	x0,4970 <main+0xc78>
    49c4:	03100713          	addi	x14,x0,49
    49c8:	f38ff06f          	jal	x0,4100 <main+0x408>
    49cc:	066a4683          	lbu	x13,102(x20)
    49d0:	06100713          	addi	x14,x0,97
    49d4:	aae692e3          	bne	x13,x14,4478 <main+0x780>
    49d8:	067a4683          	lbu	x13,103(x20)
    49dc:	07000713          	addi	x14,x0,112
    49e0:	a8e69ce3          	bne	x13,x14,4478 <main+0x780>
    49e4:	068a4683          	lbu	x13,104(x20)
    49e8:	06800713          	addi	x14,x0,104
    49ec:	a8e696e3          	bne	x13,x14,4478 <main+0x780>
    49f0:	069a4683          	lbu	x13,105(x20)
    49f4:	02800713          	addi	x14,x0,40
    49f8:	a8e690e3          	bne	x13,x14,4478 <main+0x780>
    49fc:	00fa0733          	add	x14,x20,x15
    4a00:	06374683          	lbu	x13,99(x14)
    4a04:	02900713          	addi	x14,x0,41
    4a08:	a6e698e3          	bne	x13,x14,4478 <main+0x780>
    4a0c:	02412683          	lw	x13,36(x2)
    4a10:	ff978793          	addi	x15,x15,-7
    4a14:	0ff7f793          	andi	x15,x15,255
    4a18:	00000713          	addi	x14,x0,0
    4a1c:	0066c583          	lbu	x11,6(x13)
    4a20:	0c810613          	addi	x12,x2,200
    4a24:	00e60633          	add	x12,x12,x14
    4a28:	00170713          	addi	x14,x14,1
    4a2c:	00b60023          	sb	x11,0(x12)
    4a30:	0ff77613          	andi	x12,x14,255
    4a34:	00168693          	addi	x13,x13,1
    4a38:	fef662e3          	bltu	x12,x15,4a1c <main+0xd24>
    4a3c:	07010713          	addi	x14,x2,112
    4a40:	07078793          	addi	x15,x15,112
    4a44:	00e787b3          	add	x15,x15,x14
    4a48:	fe078423          	sb	x0,-24(x15)
    4a4c:	ffffc097          	auipc	x1,0xffffc
    4a50:	340080e7          	jalr	x1,832(x1) # d8c <lcd_clear>
    4a54:	03412783          	lw	x15,52(x2)
    4a58:	478a0593          	addi	x11,x20,1144
    4a5c:	01000613          	addi	x12,x0,16
    4a60:	00078713          	addi	x14,x15,0
    4a64:	00000693          	addi	x13,x0,0
    4a68:	00d78533          	add	x10,x15,x13
    4a6c:	00050023          	sb	x0,0(x10)
    4a70:	00168693          	addi	x13,x13,1
    4a74:	fec69ae3          	bne	x13,x12,4a68 <main+0xd70>
    4a78:	01078793          	addi	x15,x15,16
    4a7c:	fef594e3          	bne	x11,x15,4a64 <main+0xd6c>
    4a80:	00000693          	addi	x13,x0,0
    4a84:	00100813          	addi	x16,x0,1
    4a88:	08000513          	addi	x10,x0,128
    4a8c:	4036d613          	srai	x12,x13,0x3
    4a90:	00ca0633          	add	x12,x20,x12
    4a94:	27864883          	lbu	x17,632(x12)
    4a98:	fff6c793          	xori	x15,x13,-1
    4a9c:	0077f793          	andi	x15,x15,7
    4aa0:	00f817b3          	sll	x15,x16,x15
    4aa4:	0117e7b3          	or	x15,x15,x17
    4aa8:	26f60c23          	sb	x15,632(x12)
    4aac:	00168693          	addi	x13,x13,1
    4ab0:	fca69ee3          	bne	x13,x10,4a8c <main+0xd94>
    4ab4:	03412783          	lw	x15,52(x2)
    4ab8:	0087c683          	lbu	x13,8(x15)
    4abc:	01078793          	addi	x15,x15,16
    4ac0:	f806e693          	ori	x13,x13,-128
    4ac4:	fed78c23          	sb	x13,-8(x15)
    4ac8:	feb798e3          	bne	x15,x11,4ab8 <main+0xdc0>
    4acc:	05812a23          	sw	x24,84(x2)
    4ad0:	00000493          	addi	x9,x0,0
    4ad4:	000b0c13          	addi	x24,x22,0
    4ad8:	08000993          	addi	x19,x0,128
    4adc:	00070b13          	addi	x22,x14,0
    4ae0:	fc048793          	addi	x15,x9,-64
    4ae4:	00006737          	lui	x14,0x6
    4ae8:	0b010593          	addi	x11,x2,176
    4aec:	0c810513          	addi	x10,x2,200
    4af0:	aaf72023          	sw	x15,-1376(x14) # 5aa0 <g_var_x_int>
    4af4:	ffffc097          	auipc	x1,0xffffc
    4af8:	144080e7          	jalr	x1,324(x1) # c38 <eval_expression>
    4afc:	02000813          	addi	x16,x0,32
    4b00:	03f00613          	addi	x12,x0,63
    4b04:	00100693          	addi	x13,x0,1
    4b08:	02050c63          	beq	x10,x0,4b40 <main+0xe48>
    4b0c:	0b012783          	lw	x15,176(x2)
    4b10:	40f807b3          	sub	x15,x16,x15
    4b14:	02f66663          	bltu	x12,x15,4b40 <main+0xe48>
    4b18:	00479793          	slli	x15,x15,0x4
    4b1c:	4034d593          	srai	x11,x9,0x3
    4b20:	00fa07b3          	add	x15,x20,x15
    4b24:	00b787b3          	add	x15,x15,x11
    4b28:	0787c503          	lbu	x10,120(x15)
    4b2c:	fff4c593          	xori	x11,x9,-1
    4b30:	0075f593          	andi	x11,x11,7
    4b34:	00b695b3          	sll	x11,x13,x11
    4b38:	00a5e5b3          	or	x11,x11,x10
    4b3c:	06b78c23          	sb	x11,120(x15)
    4b40:	00148493          	addi	x9,x9,1
    4b44:	f9349ee3          	bne	x9,x19,4ae0 <main+0xde8>
    4b48:	00100793          	addi	x15,x0,1
    4b4c:	000016b7          	lui	x13,0x1
    4b50:	aafd0223          	sb	x15,-1372(x26)
    4b54:	10004637          	lui	x12,0x10004
    4b58:	83468693          	addi	x13,x13,-1996 # 834 <parse_factor+0xf8>
    4b5c:	000017b7          	lui	x15,0x1
    4b60:	c3478793          	addi	x15,x15,-972 # c34 <parse_expression+0x12c>
    4b64:	000b0713          	addi	x14,x22,0
    4b68:	000c0b13          	addi	x22,x24,0
    4b6c:	05412c03          	lw	x24,84(x2)
    4b70:	00d62023          	sw	x13,0(x12) # 10004000 <_stack_ptr+0xfff4000>
    4b74:	00f62023          	sw	x15,0(x12)
    4b78:	00a00793          	addi	x15,x0,10
    4b7c:	08f12e23          	sw	x15,156(x2)
    4b80:	0100006f          	jal	x0,4b90 <main+0xe98>
    4b84:	09c12783          	lw	x15,156(x2)
    4b88:	fff78793          	addi	x15,x15,-1
    4b8c:	08f12e23          	sw	x15,156(x2)
    4b90:	09c12783          	lw	x15,156(x2)
    4b94:	fef048e3          	blt	x0,x15,4b84 <main+0xe8c>
    4b98:	000017b7          	lui	x15,0x1
    4b9c:	83478793          	addi	x15,x15,-1996 # 834 <parse_factor+0xf8>
    4ba0:	100046b7          	lui	x13,0x10004
    4ba4:	00f6a023          	sw	x15,0(x13) # 10004000 <_stack_ptr+0xfff4000>
    4ba8:	16800793          	addi	x15,x0,360
    4bac:	0af12023          	sw	x15,160(x2)
    4bb0:	0100006f          	jal	x0,4bc0 <main+0xec8>
    4bb4:	0a012783          	lw	x15,160(x2)
    4bb8:	fff78793          	addi	x15,x15,-1
    4bbc:	0af12023          	sw	x15,160(x2)
    4bc0:	0a012783          	lw	x15,160(x2)
    4bc4:	fef048e3          	blt	x0,x15,4bb4 <main+0xebc>
    4bc8:	000017b7          	lui	x15,0x1
    4bcc:	38878793          	addi	x15,x15,904 # 1388 <f_parse_unary+0x554>
    4bd0:	08f12c23          	sw	x15,152(x2)
    4bd4:	0100006f          	jal	x0,4be4 <main+0xeec>
    4bd8:	09812783          	lw	x15,152(x2)
    4bdc:	fff78793          	addi	x15,x15,-1
    4be0:	08f12c23          	sw	x15,152(x2)
    4be4:	09812783          	lw	x15,152(x2)
    4be8:	fef048e3          	blt	x0,x15,4bd8 <main+0xee0>
    4bec:	000015b7          	lui	x11,0x1
    4bf0:	00001637          	lui	x12,0x1
    4bf4:	80058593          	addi	x11,x11,-2048 # 800 <parse_factor+0xc4>
    4bf8:	90060613          	addi	x12,x12,-1792 # 900 <parse_factor+0x1c4>
    4bfc:	000b0f13          	addi	x30,x22,0
    4c00:	000c0f93          	addi	x31,x24,0
    4c04:	00070b13          	addi	x22,x14,0
    4c08:	00058c13          	addi	x24,x11,0
    4c0c:	00000e13          	addi	x28,x0,0
    4c10:	000c8593          	addi	x11,x25,0
    4c14:	00000793          	addi	x15,x0,0
    4c18:	00060c93          	addi	x25,x12,0
    4c1c:	08000e93          	addi	x29,x0,128
    4c20:	100044b7          	lui	x9,0x10004
    4c24:	00040713          	addi	x14,x8,0
    4c28:	000a8613          	addi	x12,x21,0
    4c2c:	f807e993          	ori	x19,x15,-128
    4c30:	0ff9f993          	andi	x19,x19,255
    4c34:	00000413          	addi	x8,x0,0
    4c38:	0189e9b3          	or	x19,x19,x24
    4c3c:	000b0a93          	addi	x21,x22,0
    4c40:	05612a23          	sw	x22,84(x2)
    4c44:	00098b13          	addi	x22,x19,0
    4c48:	00040993          	addi	x19,x8,0
    4c4c:	000e8413          	addi	x8,x29,0
    4c50:	07f12623          	sw	x31,108(x2)
    4c54:	07e12423          	sw	x30,104(x2)
    4c58:	06b12223          	sw	x11,100(x2)
    4c5c:	07c12023          	sw	x28,96(x2)
    4c60:	04c12e23          	sw	x12,92(x2)
    4c64:	04e12c23          	sw	x14,88(x2)
    4c68:	000b0513          	addi	x10,x22,0
    4c6c:	0164a023          	sw	x22,0(x9) # 10004000 <_stack_ptr+0xfff4000>
    4c70:	ffffb097          	auipc	x1,0xffffb
    4c74:	3e0080e7          	jalr	x1,992(x1) # 50 <lcd_pulse_en>
    4c78:	01340533          	add	x10,x8,x19
    4c7c:	01856533          	or	x10,x10,x24
    4c80:	00a4a023          	sw	x10,0(x9)
    4c84:	ffffb097          	auipc	x1,0xffffb
    4c88:	3cc080e7          	jalr	x1,972(x1) # 50 <lcd_pulse_en>
    4c8c:	000ac503          	lbu	x10,0(x21)
    4c90:	00198993          	addi	x19,x19,1
    4c94:	002a8a93          	addi	x21,x21,2
    4c98:	01956533          	or	x10,x10,x25
    4c9c:	00a4a023          	sw	x10,0(x9)
    4ca0:	ffffb097          	auipc	x1,0xffffb
    4ca4:	3b0080e7          	jalr	x1,944(x1) # 50 <lcd_pulse_en>
    4ca8:	fffac503          	lbu	x10,-1(x21)
    4cac:	01956533          	or	x10,x10,x25
    4cb0:	00a4a023          	sw	x10,0(x9)
    4cb4:	ffffb097          	auipc	x1,0xffffb
    4cb8:	39c080e7          	jalr	x1,924(x1) # 50 <lcd_pulse_en>
    4cbc:	00800313          	addi	x6,x0,8
    4cc0:	05812703          	lw	x14,88(x2)
    4cc4:	05c12603          	lw	x12,92(x2)
    4cc8:	06012e03          	lw	x28,96(x2)
    4ccc:	06412583          	lw	x11,100(x2)
    4cd0:	06812f03          	lw	x30,104(x2)
    4cd4:	06c12f83          	lw	x31,108(x2)
    4cd8:	04000893          	addi	x17,x0,64
    4cdc:	01f00813          	addi	x16,x0,31
    4ce0:	f66998e3          	bne	x19,x6,4c50 <main+0xf58>
    4ce4:	05412b03          	lw	x22,84(x2)
    4ce8:	001e0693          	addi	x13,x28,1
    4cec:	0ff6f693          	andi	x13,x13,255
    4cf0:	010b0b13          	addi	x22,x22,16
    4cf4:	73168463          	beq	x13,x17,541c <main+0x1724>
    4cf8:	7cd87463          	bgeu	x16,x13,54c0 <main+0x17c8>
    4cfc:	fe1e0793          	addi	x15,x28,-31
    4d00:	0ff7f793          	andi	x15,x15,255
    4d04:	08800e93          	addi	x29,x0,136
    4d08:	00068e13          	addi	x28,x13,0
    4d0c:	f21ff06f          	jal	x0,4c2c <main+0xf34>
    4d10:	03900713          	addi	x14,x0,57
    4d14:	becff06f          	jal	x0,4100 <main+0x408>
    4d18:	02e00713          	addi	x14,x0,46
    4d1c:	be4ff06f          	jal	x0,4100 <main+0x408>
    4d20:	03400713          	addi	x14,x0,52
    4d24:	bdcff06f          	jal	x0,4100 <main+0x408>
    4d28:	03800713          	addi	x14,x0,56
    4d2c:	bd4ff06f          	jal	x0,4100 <main+0x408>
    4d30:	03700713          	addi	x14,x0,55
    4d34:	bccff06f          	jal	x0,4100 <main+0x408>
    4d38:	03500713          	addi	x14,x0,53
    4d3c:	bc4ff06f          	jal	x0,4100 <main+0x408>
    4d40:	03200713          	addi	x14,x0,50
    4d44:	bbcff06f          	jal	x0,4100 <main+0x408>
    4d48:	03300713          	addi	x14,x0,51
    4d4c:	bb4ff06f          	jal	x0,4100 <main+0x408>
    4d50:	03000713          	addi	x14,x0,48
    4d54:	bacff06f          	jal	x0,4100 <main+0x408>
    4d58:	05200713          	addi	x14,x0,82
    4d5c:	ba0a9263          	bne	x21,x0,4100 <main+0x408>
    4d60:	07200713          	addi	x14,x0,114
    4d64:	b9cff06f          	jal	x0,4100 <main+0x408>
    4d68:	04700713          	addi	x14,x0,71
    4d6c:	b80a9a63          	bne	x21,x0,4100 <main+0x408>
    4d70:	06700713          	addi	x14,x0,103
    4d74:	b8cff06f          	jal	x0,4100 <main+0x408>
    4d78:	04800713          	addi	x14,x0,72
    4d7c:	b80a9263          	bne	x21,x0,4100 <main+0x408>
    4d80:	06800713          	addi	x14,x0,104
    4d84:	b7cff06f          	jal	x0,4100 <main+0x408>
    4d88:	05800713          	addi	x14,x0,88
    4d8c:	b60a9a63          	bne	x21,x0,4100 <main+0x408>
    4d90:	07800713          	addi	x14,x0,120
    4d94:	b6cff06f          	jal	x0,4100 <main+0x408>
    4d98:	04300713          	addi	x14,x0,67
    4d9c:	b60a9263          	bne	x21,x0,4100 <main+0x408>
    4da0:	06300713          	addi	x14,x0,99
    4da4:	b5cff06f          	jal	x0,4100 <main+0x408>
    4da8:	05400713          	addi	x14,x0,84
    4dac:	b40a9a63          	bne	x21,x0,4100 <main+0x408>
    4db0:	07400713          	addi	x14,x0,116
    4db4:	b4cff06f          	jal	x0,4100 <main+0x408>
    4db8:	04600713          	addi	x14,x0,70
    4dbc:	b40a9263          	bne	x21,x0,4100 <main+0x408>
    4dc0:	06600713          	addi	x14,x0,102
    4dc4:	b3cff06f          	jal	x0,4100 <main+0x408>
    4dc8:	04d00713          	addi	x14,x0,77
    4dcc:	b20a9a63          	bne	x21,x0,4100 <main+0x408>
    4dd0:	06d00713          	addi	x14,x0,109
    4dd4:	b2cff06f          	jal	x0,4100 <main+0x408>
    4dd8:	05e00713          	addi	x14,x0,94
    4ddc:	b20a9263          	bne	x21,x0,4100 <main+0x408>
    4de0:	03600713          	addi	x14,x0,54
    4de4:	b1cff06f          	jal	x0,4100 <main+0x408>
    4de8:	05900713          	addi	x14,x0,89
    4dec:	b00a9a63          	bne	x21,x0,4100 <main+0x408>
    4df0:	07900713          	addi	x14,x0,121
    4df4:	b0cff06f          	jal	x0,4100 <main+0x408>
    4df8:	04c00713          	addi	x14,x0,76
    4dfc:	b00a9263          	bne	x21,x0,4100 <main+0x408>
    4e00:	06c00713          	addi	x14,x0,108
    4e04:	afcff06f          	jal	x0,4100 <main+0x408>
    4e08:	04900713          	addi	x14,x0,73
    4e0c:	ae0a9a63          	bne	x21,x0,4100 <main+0x408>
    4e10:	06900713          	addi	x14,x0,105
    4e14:	aecff06f          	jal	x0,4100 <main+0x408>
    4e18:	04b00713          	addi	x14,x0,75
    4e1c:	ae0a9263          	bne	x21,x0,4100 <main+0x408>
    4e20:	06b00713          	addi	x14,x0,107
    4e24:	adcff06f          	jal	x0,4100 <main+0x408>
    4e28:	04500713          	addi	x14,x0,69
    4e2c:	ac0a9a63          	bne	x21,x0,4100 <main+0x408>
    4e30:	06500713          	addi	x14,x0,101
    4e34:	accff06f          	jal	x0,4100 <main+0x408>
    4e38:	04400713          	addi	x14,x0,68
    4e3c:	ac0a9263          	bne	x21,x0,4100 <main+0x408>
    4e40:	06400713          	addi	x14,x0,100
    4e44:	abcff06f          	jal	x0,4100 <main+0x408>
    4e48:	04f00713          	addi	x14,x0,79
    4e4c:	aa0a9a63          	bne	x21,x0,4100 <main+0x408>
    4e50:	06f00713          	addi	x14,x0,111
    4e54:	aacff06f          	jal	x0,4100 <main+0x408>
    4e58:	05700713          	addi	x14,x0,87
    4e5c:	aa0a9263          	bne	x21,x0,4100 <main+0x408>
    4e60:	07700713          	addi	x14,x0,119
    4e64:	a9cff06f          	jal	x0,4100 <main+0x408>
    4e68:	04100713          	addi	x14,x0,65
    4e6c:	a80a9a63          	bne	x21,x0,4100 <main+0x408>
    4e70:	06100713          	addi	x14,x0,97
    4e74:	a8cff06f          	jal	x0,4100 <main+0x408>
    4e78:	05300713          	addi	x14,x0,83
    4e7c:	a80a9263          	bne	x21,x0,4100 <main+0x408>
    4e80:	07300713          	addi	x14,x0,115
    4e84:	a7cff06f          	jal	x0,4100 <main+0x408>
    4e88:	05100713          	addi	x14,x0,81
    4e8c:	a60a9a63          	bne	x21,x0,4100 <main+0x408>
    4e90:	07100713          	addi	x14,x0,113
    4e94:	a6cff06f          	jal	x0,4100 <main+0x408>
    4e98:	05a00713          	addi	x14,x0,90
    4e9c:	a60a9263          	bne	x21,x0,4100 <main+0x408>
    4ea0:	07a00713          	addi	x14,x0,122
    4ea4:	a5cff06f          	jal	x0,4100 <main+0x408>
    4ea8:	04200713          	addi	x14,x0,66
    4eac:	a40a9a63          	bne	x21,x0,4100 <main+0x408>
    4eb0:	06200713          	addi	x14,x0,98
    4eb4:	a4cff06f          	jal	x0,4100 <main+0x408>
    4eb8:	04e00713          	addi	x14,x0,78
    4ebc:	a40a9263          	bne	x21,x0,4100 <main+0x408>
    4ec0:	06e00713          	addi	x14,x0,110
    4ec4:	a3cff06f          	jal	x0,4100 <main+0x408>
    4ec8:	05000713          	addi	x14,x0,80
    4ecc:	a20a9a63          	bne	x21,x0,4100 <main+0x408>
    4ed0:	07000713          	addi	x14,x0,112
    4ed4:	a2cff06f          	jal	x0,4100 <main+0x408>
    4ed8:	05500713          	addi	x14,x0,85
    4edc:	a20a9263          	bne	x21,x0,4100 <main+0x408>
    4ee0:	07500713          	addi	x14,x0,117
    4ee4:	a1cff06f          	jal	x0,4100 <main+0x408>
    4ee8:	05600713          	addi	x14,x0,86
    4eec:	a00a9a63          	bne	x21,x0,4100 <main+0x408>
    4ef0:	07600713          	addi	x14,x0,118
    4ef4:	a0cff06f          	jal	x0,4100 <main+0x408>
    4ef8:	04a00713          	addi	x14,x0,74
    4efc:	a00a9263          	bne	x21,x0,4100 <main+0x408>
    4f00:	06a00713          	addi	x14,x0,106
    4f04:	9fcff06f          	jal	x0,4100 <main+0x408>
    4f08:	02800713          	addi	x14,x0,40
    4f0c:	9f4ff06f          	jal	x0,4100 <main+0x408>
    4f10:	02000713          	addi	x14,x0,32
    4f14:	9ecff06f          	jal	x0,4100 <main+0x408>
    4f18:	02f00713          	addi	x14,x0,47
    4f1c:	9e4ff06f          	jal	x0,4100 <main+0x408>
    4f20:	02c00713          	addi	x14,x0,44
    4f24:	9dcff06f          	jal	x0,4100 <main+0x408>
    4f28:	2e070a63          	beq	x14,x0,521c <main+0x1524>
    4f2c:	000057b7          	lui	x15,0x5
    4f30:	04012703          	lw	x14,64(x2)
    4f34:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    4f38:	0100006f          	jal	x0,4f48 <main+0x1250>
    4f3c:	00178793          	addi	x15,x15,1
    4f40:	00170713          	addi	x14,x14,1
    4f44:	fed78fa3          	sb	x13,-1(x15)
    4f48:	00074683          	lbu	x13,0(x14)
    4f4c:	fe0698e3          	bne	x13,x0,4f3c <main+0x1244>
    4f50:	e94ff06f          	jal	x0,45e4 <main+0x8ec>
    4f54:	03400713          	addi	x14,x0,52
    4f58:	9a8ff06f          	jal	x0,4100 <main+0x408>
    4f5c:	02e00713          	addi	x14,x0,46
    4f60:	9a0ff06f          	jal	x0,4100 <main+0x408>
    4f64:	03100713          	addi	x14,x0,49
    4f68:	998ff06f          	jal	x0,4100 <main+0x408>
    4f6c:	03200713          	addi	x14,x0,50
    4f70:	990ff06f          	jal	x0,4100 <main+0x408>
    4f74:	02a00713          	addi	x14,x0,42
    4f78:	988ff06f          	jal	x0,4100 <main+0x408>
    4f7c:	02d00713          	addi	x14,x0,45
    4f80:	980ff06f          	jal	x0,4100 <main+0x408>
    4f84:	02b00713          	addi	x14,x0,43
    4f88:	978ff06f          	jal	x0,4100 <main+0x408>
    4f8c:	03600713          	addi	x14,x0,54
    4f90:	970ff06f          	jal	x0,4100 <main+0x408>
    4f94:	02900713          	addi	x14,x0,41
    4f98:	968ff06f          	jal	x0,4100 <main+0x408>
    4f9c:	03700713          	addi	x14,x0,55
    4fa0:	960ff06f          	jal	x0,4100 <main+0x408>
    4fa4:	03800713          	addi	x14,x0,56
    4fa8:	958ff06f          	jal	x0,4100 <main+0x408>
    4fac:	03000713          	addi	x14,x0,48
    4fb0:	950ff06f          	jal	x0,4100 <main+0x408>
    4fb4:	03900713          	addi	x14,x0,57
    4fb8:	948ff06f          	jal	x0,4100 <main+0x408>
    4fbc:	03300713          	addi	x14,x0,51
    4fc0:	940ff06f          	jal	x0,4100 <main+0x408>
    4fc4:	03500713          	addi	x14,x0,53
    4fc8:	938ff06f          	jal	x0,4100 <main+0x408>
    4fcc:	0b012703          	lw	x14,176(x2)
    4fd0:	0e070863          	beq	x14,x0,50c0 <main+0x13c8>
    4fd4:	00075663          	bge	x14,x0,4fe0 <main+0x12e8>
    4fd8:	40e00733          	sub	x14,x0,x14
    4fdc:	00100793          	addi	x15,x0,1
    4fe0:	00000613          	addi	x12,x0,0
    4fe4:	04812a23          	sw	x8,84(x2)
    4fe8:	04912c23          	sw	x9,88(x2)
    4fec:	0c810993          	addi	x19,x2,200
    4ff0:	00070413          	addi	x8,x14,0
    4ff4:	04f12e23          	sw	x15,92(x2)
    4ff8:	00060493          	addi	x9,x12,0
    4ffc:	00a00593          	addi	x11,x0,10
    5000:	00040513          	addi	x10,x8,0
    5004:	ffffe097          	auipc	x1,0xffffe
    5008:	760080e7          	jalr	x1,1888(x1) # 3764 <__modsi3>
    500c:	03050793          	addi	x15,x10,48
    5010:	00f98023          	sb	x15,0(x19)
    5014:	00040513          	addi	x10,x8,0
    5018:	00a00593          	addi	x11,x0,10
    501c:	ffffe097          	auipc	x1,0xffffe
    5020:	6c4080e7          	jalr	x1,1732(x1) # 36e0 <__divsi3>
    5024:	00148493          	addi	x9,x9,1
    5028:	00050413          	addi	x8,x10,0
    502c:	00198993          	addi	x19,x19,1
    5030:	fc0516e3          	bne	x10,x0,4ffc <main+0x1304>
    5034:	05c12783          	lw	x15,92(x2)
    5038:	00048613          	addi	x12,x9,0
    503c:	05412403          	lw	x8,84(x2)
    5040:	05812483          	lw	x9,88(x2)
    5044:	00078863          	beq	x15,x0,5054 <main+0x135c>
    5048:	02d00793          	addi	x15,x0,45
    504c:	04fa0023          	sb	x15,64(x20)
    5050:	00100493          	addi	x9,x0,1
    5054:	000055b7          	lui	x11,0x5
    5058:	66858713          	addi	x14,x11,1640 # 5668 <g_result>
    505c:	041a0693          	addi	x13,x20,65
    5060:	66858593          	addi	x11,x11,1640
    5064:	00060793          	addi	x15,x12,0
    5068:	00970733          	add	x14,x14,x9
    506c:	40b686b3          	sub	x13,x13,x11
    5070:	fff78793          	addi	x15,x15,-1
    5074:	0c810593          	addi	x11,x2,200
    5078:	00f585b3          	add	x11,x11,x15
    507c:	0005c583          	lbu	x11,0(x11)
    5080:	00b70023          	sb	x11,0(x14)
    5084:	00d70733          	add	x14,x14,x13
    5088:	fe0794e3          	bne	x15,x0,5070 <main+0x1378>
    508c:	009a07b3          	add	x15,x20,x9
    5090:	00c787b3          	add	x15,x15,x12
    5094:	04078023          	sb	x0,64(x15)
    5098:	d50ff06f          	jal	x0,45e8 <main+0x8f0>
    509c:	000057b7          	lui	x15,0x5
    50a0:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    50a4:	0100006f          	jal	x0,50b4 <main+0x13bc>
    50a8:	00178793          	addi	x15,x15,1
    50ac:	00170713          	addi	x14,x14,1
    50b0:	fed78fa3          	sb	x13,-1(x15)
    50b4:	00074683          	lbu	x13,0(x14)
    50b8:	fe0698e3          	bne	x13,x0,50a8 <main+0x13b0>
    50bc:	8b5ff06f          	jal	x0,4970 <main+0xc78>
    50c0:	03000793          	addi	x15,x0,48
    50c4:	04fa1023          	sh	x15,64(x20)
    50c8:	d20ff06f          	jal	x0,45e8 <main+0x8f0>
    50cc:	000057b7          	lui	x15,0x5
    50d0:	fff48493          	addi	x9,x9,-1
    50d4:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    50d8:	009787b3          	add	x15,x15,x9
    50dc:	0007c683          	lbu	x13,0(x15)
    50e0:	02e00713          	addi	x14,x0,46
    50e4:	d0e69263          	bne	x13,x14,45e8 <main+0x8f0>
    50e8:	cfcff06f          	jal	x0,45e4 <main+0x8ec>
    50ec:	000f46b7          	lui	x13,0xf4
    50f0:	23f68693          	addi	x13,x13,575 # f423f <_stack_ptr+0xe423f>
    50f4:	dae6e663          	bltu	x13,x14,46a0 <main+0x9a8>
    50f8:	00078713          	addi	x14,x15,0
    50fc:	00098793          	addi	x15,x19,0
    5100:	00078993          	addi	x19,x15,0
    5104:	03000793          	addi	x15,x0,48
    5108:	0af11823          	sh	x15,176(x2)
    510c:	00070793          	addi	x15,x14,0
    5110:	e80ff06f          	jal	x0,4790 <main+0xa98>
    5114:	000f4637          	lui	x12,0xf4
    5118:	00a76533          	or	x10,x14,x10
    511c:	24060613          	addi	x12,x12,576 # f4240 <_stack_ptr+0xe4240>
    5120:	f6a98713          	addi	x14,x19,-150
    5124:	00000693          	addi	x13,x0,0
    5128:	00000593          	addi	x11,x0,0
    512c:	04f12c23          	sw	x15,88(x2)
    5130:	04e12a23          	sw	x14,84(x2)
    5134:	ffffe097          	auipc	x1,0xffffe
    5138:	518080e7          	jalr	x1,1304(x1) # 364c <__muldi3>
    513c:	05412703          	lw	x14,84(x2)
    5140:	05812783          	lw	x15,88(x2)
    5144:	1e074e63          	blt	x14,x0,5340 <main+0x1648>
    5148:	01f00613          	addi	x12,x0,31
    514c:	1ce64663          	blt	x12,x14,5318 <main+0x1620>
    5150:	00070613          	addi	x12,x14,0
    5154:	04f12a23          	sw	x15,84(x2)
    5158:	ffffd097          	auipc	x1,0xffffd
    515c:	d40080e7          	jalr	x1,-704(x1) # 1e98 <__ashldi3>
    5160:	05412783          	lw	x15,84(x2)
    5164:	00050713          	addi	x14,x10,0
    5168:	00058813          	addi	x16,x11,0
    516c:	000f4637          	lui	x12,0xf4
    5170:	24060613          	addi	x12,x12,576 # f4240 <_stack_ptr+0xe4240>
    5174:	00000693          	addi	x13,x0,0
    5178:	00070513          	addi	x10,x14,0
    517c:	00080593          	addi	x11,x16,0
    5180:	06f12223          	sw	x15,100(x2)
    5184:	04e12c23          	sw	x14,88(x2)
    5188:	05012a23          	sw	x16,84(x2)
    518c:	ffffe097          	auipc	x1,0xffffe
    5190:	940080e7          	jalr	x1,-1728(x1) # 2acc <__udivdi3>
    5194:	05812703          	lw	x14,88(x2)
    5198:	05412803          	lw	x16,84(x2)
    519c:	000f4637          	lui	x12,0xf4
    51a0:	00050893          	addi	x17,x10,0
    51a4:	00058313          	addi	x6,x11,0
    51a8:	00070513          	addi	x10,x14,0
    51ac:	00080593          	addi	x11,x16,0
    51b0:	24060613          	addi	x12,x12,576 # f4240 <_stack_ptr+0xe4240>
    51b4:	00000693          	addi	x13,x0,0
    51b8:	06e12023          	sw	x14,96(x2)
    51bc:	05012e23          	sw	x16,92(x2)
    51c0:	05112c23          	sw	x17,88(x2)
    51c4:	04612a23          	sw	x6,84(x2)
    51c8:	ffffe097          	auipc	x1,0xffffe
    51cc:	f38080e7          	jalr	x1,-200(x1) # 3100 <__umoddi3>
    51d0:	06412783          	lw	x15,100(x2)
    51d4:	040a0023          	sb	x0,64(x20)
    51d8:	05412303          	lw	x6,84(x2)
    51dc:	05812883          	lw	x17,88(x2)
    51e0:	05c12803          	lw	x16,92(x2)
    51e4:	06012703          	lw	x14,96(x2)
    51e8:	00050993          	addi	x19,x10,0
    51ec:	ca078863          	beq	x15,x0,469c <main+0x9a4>
    51f0:	ca0ff06f          	jal	x0,4690 <main+0x998>
    51f4:	000057b7          	lui	x15,0x5
    51f8:	04c12703          	lw	x14,76(x2)
    51fc:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    5200:	0100006f          	jal	x0,5210 <main+0x1518>
    5204:	00178793          	addi	x15,x15,1
    5208:	00170713          	addi	x14,x14,1
    520c:	fed78fa3          	sb	x13,-1(x15)
    5210:	00074683          	lbu	x13,0(x14)
    5214:	fe0698e3          	bne	x13,x0,5204 <main+0x150c>
    5218:	bccff06f          	jal	x0,45e4 <main+0x8ec>
    521c:	04079a63          	bne	x15,x0,5270 <main+0x1578>
    5220:	000057b7          	lui	x15,0x5
    5224:	04812703          	lw	x14,72(x2)
    5228:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    522c:	0100006f          	jal	x0,523c <main+0x1544>
    5230:	00178793          	addi	x15,x15,1
    5234:	00170713          	addi	x14,x14,1
    5238:	fed78fa3          	sb	x13,-1(x15)
    523c:	00074683          	lbu	x13,0(x14)
    5240:	fe0698e3          	bne	x13,x0,5230 <main+0x1538>
    5244:	ba0ff06f          	jal	x0,45e4 <main+0x8ec>
    5248:	04800713          	addi	x14,x0,72
    524c:	eb5fe06f          	jal	x0,4100 <main+0x408>
    5250:	04e00713          	addi	x14,x0,78
    5254:	eadfe06f          	jal	x0,4100 <main+0x408>
    5258:	04200713          	addi	x14,x0,66
    525c:	ea5fe06f          	jal	x0,4100 <main+0x408>
    5260:	05900713          	addi	x14,x0,89
    5264:	e9dfe06f          	jal	x0,4100 <main+0x408>
    5268:	04700713          	addi	x14,x0,71
    526c:	e95fe06f          	jal	x0,4100 <main+0x408>
    5270:	000057b7          	lui	x15,0x5
    5274:	04412703          	lw	x14,68(x2)
    5278:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    527c:	0100006f          	jal	x0,528c <main+0x1594>
    5280:	00178793          	addi	x15,x15,1
    5284:	00170713          	addi	x14,x14,1
    5288:	fed78fa3          	sb	x13,-1(x15)
    528c:	00074683          	lbu	x13,0(x14)
    5290:	fe0698e3          	bne	x13,x0,5280 <main+0x1588>
    5294:	b50ff06f          	jal	x0,45e4 <main+0x8ec>
    5298:	05e00713          	addi	x14,x0,94
    529c:	e65fe06f          	jal	x0,4100 <main+0x408>
    52a0:	04d00713          	addi	x14,x0,77
    52a4:	e5dfe06f          	jal	x0,4100 <main+0x408>
    52a8:	05300713          	addi	x14,x0,83
    52ac:	e55fe06f          	jal	x0,4100 <main+0x408>
    52b0:	04100713          	addi	x14,x0,65
    52b4:	e4dfe06f          	jal	x0,4100 <main+0x408>
    52b8:	02b00713          	addi	x14,x0,43
    52bc:	e45fe06f          	jal	x0,4100 <main+0x408>
    52c0:	02d00713          	addi	x14,x0,45
    52c4:	e3dfe06f          	jal	x0,4100 <main+0x408>
    52c8:	02000713          	addi	x14,x0,32
    52cc:	e35fe06f          	jal	x0,4100 <main+0x408>
    52d0:	05600713          	addi	x14,x0,86
    52d4:	e2dfe06f          	jal	x0,4100 <main+0x408>
    52d8:	05a00713          	addi	x14,x0,90
    52dc:	e25fe06f          	jal	x0,4100 <main+0x408>
    52e0:	05700713          	addi	x14,x0,87
    52e4:	e1dfe06f          	jal	x0,4100 <main+0x408>
    52e8:	05100713          	addi	x14,x0,81
    52ec:	e15fe06f          	jal	x0,4100 <main+0x408>
    52f0:	02a00713          	addi	x14,x0,42
    52f4:	e0dfe06f          	jal	x0,4100 <main+0x408>
    52f8:	04300713          	addi	x14,x0,67
    52fc:	e05fe06f          	jal	x0,4100 <main+0x408>
    5300:	05800713          	addi	x14,x0,88
    5304:	dfdfe06f          	jal	x0,4100 <main+0x408>
    5308:	04400713          	addi	x14,x0,68
    530c:	df5fe06f          	jal	x0,4100 <main+0x408>
    5310:	04500713          	addi	x14,x0,69
    5314:	dedfe06f          	jal	x0,4100 <main+0x408>
    5318:	000057b7          	lui	x15,0x5
    531c:	05012703          	lw	x14,80(x2)
    5320:	66878793          	addi	x15,x15,1640 # 5668 <g_result>
    5324:	0100006f          	jal	x0,5334 <main+0x163c>
    5328:	00178793          	addi	x15,x15,1
    532c:	00170713          	addi	x14,x14,1
    5330:	fed78fa3          	sb	x13,-1(x15)
    5334:	00074683          	lbu	x13,0(x14)
    5338:	fe0698e3          	bne	x13,x0,5328 <main+0x1630>
    533c:	aa8ff06f          	jal	x0,45e4 <main+0x8ec>
    5340:	04b12e23          	sw	x11,92(x2)
    5344:	04a12c23          	sw	x10,88(x2)
    5348:	fc100613          	addi	x12,x0,-63
    534c:	b2c74263          	blt	x14,x12,4670 <main+0x978>
    5350:	fff74613          	xori	x12,x14,-1
    5354:	00100513          	addi	x10,x0,1
    5358:	00000593          	addi	x11,x0,0
    535c:	04f12a23          	sw	x15,84(x2)
    5360:	ffffd097          	auipc	x1,0xffffd
    5364:	b38080e7          	jalr	x1,-1224(x1) # 1e98 <__ashldi3>
    5368:	05812803          	lw	x16,88(x2)
    536c:	05c12683          	lw	x13,92(x2)
    5370:	00050713          	addi	x14,x10,0
    5374:	01050533          	add	x10,x10,x16
    5378:	00e53733          	sltu	x14,x10,x14
    537c:	00d585b3          	add	x11,x11,x13
    5380:	09600613          	addi	x12,x0,150
    5384:	00b705b3          	add	x11,x14,x11
    5388:	41360633          	sub	x12,x12,x19
    538c:	ffffd097          	auipc	x1,0xffffd
    5390:	ad4080e7          	jalr	x1,-1324(x1) # 1e60 <__lshrdi3>
    5394:	05412783          	lw	x15,84(x2)
    5398:	00050713          	addi	x14,x10,0
    539c:	00058813          	addi	x16,x11,0
    53a0:	dcdff06f          	jal	x0,516c <main+0x1474>
    53a4:	04b00713          	addi	x14,x0,75
    53a8:	d59fe06f          	jal	x0,4100 <main+0x408>
    53ac:	04900713          	addi	x14,x0,73
    53b0:	d51fe06f          	jal	x0,4100 <main+0x408>
    53b4:	05000713          	addi	x14,x0,80
    53b8:	d49fe06f          	jal	x0,4100 <main+0x408>
    53bc:	02800713          	addi	x14,x0,40
    53c0:	d41fe06f          	jal	x0,4100 <main+0x408>
    53c4:	02900713          	addi	x14,x0,41
    53c8:	d39fe06f          	jal	x0,4100 <main+0x408>
    53cc:	03600713          	addi	x14,x0,54
    53d0:	d31fe06f          	jal	x0,4100 <main+0x408>
    53d4:	02f00713          	addi	x14,x0,47
    53d8:	d29fe06f          	jal	x0,4100 <main+0x408>
    53dc:	04c00713          	addi	x14,x0,76
    53e0:	d21fe06f          	jal	x0,4100 <main+0x408>
    53e4:	05200713          	addi	x14,x0,82
    53e8:	d19fe06f          	jal	x0,4100 <main+0x408>
    53ec:	05500713          	addi	x14,x0,85
    53f0:	d11fe06f          	jal	x0,4100 <main+0x408>
    53f4:	02c00713          	addi	x14,x0,44
    53f8:	d09fe06f          	jal	x0,4100 <main+0x408>
    53fc:	04f00713          	addi	x14,x0,79
    5400:	d01fe06f          	jal	x0,4100 <main+0x408>
    5404:	04600713          	addi	x14,x0,70
    5408:	cf9fe06f          	jal	x0,4100 <main+0x408>
    540c:	05400713          	addi	x14,x0,84
    5410:	cf1fe06f          	jal	x0,4100 <main+0x408>
    5414:	04a00713          	addi	x14,x0,74
    5418:	ce9fe06f          	jal	x0,4100 <main+0x408>
    541c:	00070413          	addi	x8,x14,0
    5420:	00001737          	lui	x14,0x1
    5424:	83670713          	addi	x14,x14,-1994 # 836 <parse_factor+0xfa>
    5428:	000017b7          	lui	x15,0x1
    542c:	00e4a023          	sw	x14,0(x9)
    5430:	c3678793          	addi	x15,x15,-970 # c36 <parse_expression+0x12e>
    5434:	00f4a023          	sw	x15,0(x9)
    5438:	00a00793          	addi	x15,x0,10
    543c:	00060a93          	addi	x21,x12,0
    5440:	00058c93          	addi	x25,x11,0
    5444:	000f0b13          	addi	x22,x30,0
    5448:	000f8c13          	addi	x24,x31,0
    544c:	0af12423          	sw	x15,168(x2)
    5450:	0100006f          	jal	x0,5460 <main+0x1768>
    5454:	0a812783          	lw	x15,168(x2)
    5458:	fff78793          	addi	x15,x15,-1
    545c:	0af12423          	sw	x15,168(x2)
    5460:	0a812783          	lw	x15,168(x2)
    5464:	fef048e3          	blt	x0,x15,5454 <main+0x175c>
    5468:	000017b7          	lui	x15,0x1
    546c:	83678793          	addi	x15,x15,-1994 # 836 <parse_factor+0xfa>
    5470:	10004737          	lui	x14,0x10004
    5474:	00f72023          	sw	x15,0(x14) # 10004000 <_stack_ptr+0xfff4000>
    5478:	16800793          	addi	x15,x0,360
    547c:	0af12623          	sw	x15,172(x2)
    5480:	0100006f          	jal	x0,5490 <main+0x1798>
    5484:	0ac12783          	lw	x15,172(x2)
    5488:	fff78793          	addi	x15,x15,-1
    548c:	0af12623          	sw	x15,172(x2)
    5490:	0ac12783          	lw	x15,172(x2)
    5494:	fef048e3          	blt	x0,x15,5484 <main+0x178c>
    5498:	000017b7          	lui	x15,0x1
    549c:	38878793          	addi	x15,x15,904 # 1388 <f_parse_unary+0x554>
    54a0:	0af12223          	sw	x15,164(x2)
    54a4:	0100006f          	jal	x0,54b4 <main+0x17bc>
    54a8:	0a412783          	lw	x15,164(x2)
    54ac:	fff78793          	addi	x15,x15,-1
    54b0:	0af12223          	sw	x15,164(x2)
    54b4:	0a412783          	lw	x15,164(x2)
    54b8:	fef048e3          	blt	x0,x15,54a8 <main+0x17b0>
    54bc:	bddfe06f          	jal	x0,4098 <main+0x3a0>
    54c0:	00068793          	addi	x15,x13,0
    54c4:	08000e93          	addi	x29,x0,128
    54c8:	00068e13          	addi	x28,x13,0
    54cc:	f60ff06f          	jal	x0,4c2c <main+0xf34>

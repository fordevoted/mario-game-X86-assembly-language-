INCLUDE Irvine32.inc
INCLUDE Macros.inc
timerT PROTO
turnback proto
buildclockType proto ,judge:DWORD
map proto 
Map_Width=71
Map_Height=15
.data
attributes0 WORD Map_Width DUP(lightRed)
attributes1 WORD green ,(Map_Width-2) DUP(yellow),lightblue
attributes2 WORD MAP_Width DUP(lightCyan)
MAP_TOP BYTE 0DAh, (Map_Width - 2) DUP(0C4h), 0BFh,0
MAP_MID BYTE 0B3h, (Map_Width - 2) DUP(' '), 0B3h,0
MAP_BOT BYTE 0C0h, (Map_Width - 2) DUP(0C4h),0D9h,0

xyInit COORD <22 ,0> ; �a�ϰ_�l�y��
xyBoundR COORD <93,14> ; �@�ӭ����̤j�����
xyBoundL COORD <23,1>  
xyPosition COORD <24,14> ; �{�b����Ц�m
xyRestart   COORD <24,14>	;���s�}�l���y��
xyMap COORD <0,0>; �p�ɾ�����m

consoleHandle    DWORD ?		;api�ϥ��ܼ�
outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD 0
cellsWritten DWORD ?

countineTime DWORD ?		;�{�����Ҷ��ϥΨ��ܼ�
startTime   DWORD   ?
timer    	DWORD  600
timer1 	    DWORD  60		;���d�]�w�ɶ�
timer2		DWORD  90
timer3		DWORD  120
i	    DWORD   ?
body Byte "!@_@!"
space byte ' '
dir byte ?
decidex word ?
decidey word ?
T byte ?
score Word 0
MapNow   DWORD 0


barrier4 BYTE '*********************************************************************'			;ThornsBarrier
         byte '*DDDDDDDDDD  G      *  *     G                        DDDDDDDDDD    *'
         byte '* D **  **D    ** ****  ******   ******   ***  ****** D ******  D****'
         byte '*  D* *   D G *** ****   *****   ******   ***  ****** D ****** D ****'
         byte '* G D     D*           G                       G      D ******D    G*'
		 byte '*****DDDDDD * ***   ***********************   *****   DDDDDDDD ******'
		 byte '*G      ***   *  G         **          **       *                  **'
         byte '********     **  *         **     G    **       *         ***********'
         byte '*            B    ***          B  **  D                 *           *'
		 byte '*  * **    ****     *    B     **    **            ** T T  T T T    *'
		 byte '*    T*  *           G           T G           **         *  ********'
		 byte '*B   *G   * T     B**********   ********     B   G**       ***GGGGGG*'
		 byte '*** *** ****** ***  ************ ********    ************    ********'
		 byte '*                       *DDD              G                         *'
         byte '*********************************************************************'

sky1     BYTE '*********************************************************************'				;SkyCastle
         byte '*                                                                   *'
         byte '*  **   **   ***  ****   *****   ******   ***  ******   ******   ****'
         byte 'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG*'
         byte '********   ***    ***********************   *****         ***********'
         BYTE '      G       ****                    D DG         DDDDT            *'
         byte '********  B      G  *      *G*      *****     G           ***********'
         byte '********  B      *     G G  G*****        G B   G         ***********'
         byte '*TBBBBB      G   * *      G       **      ********      G           *'
         byte '********   *****   ***         ***  ***                 T           *'
         BYTE '       BBBB     B         ****   B             GTBD         B G     *'
		 byte 'D T D D   G     *G      **   BBB       G      **********     ********'
		 byte '                T      ***            G                       BBBBTD*'
		 byte '          ***********              D  T     *************   *********'
         byte '*********************************************************************'

map3     BYTE '*********************************************************************'			;DivinityAltar
         byte '*                              NCU CSIE                             *'
         byte '****    *****    ***  ******DivinityAltar******   ***   ******   ****'
         byte '*  **   **   ***  ****   **    ********   ***  ******   ******   ****'
         byte '*          G        G       **               G  G G       T  D B    *' 
         BYTE '*       T  *********************************************            *'
         byte '*     T ****       **************  ************      ****  G        *'
         byte '*   ****   *** **     *****G*****    **********      G   ***     G  *'
         byte '*  G      G     G      ****G*********  **********  T          *     *'
         byte '*  *    G***    ***     *****G*****    **********            ***    *'
		 BYTE '*****    B  ***        BBBDBBTTTBB  ***********           *** *     *'
	 	 byte '*     *** G                           GG             ***   *  *    B*'
		 byte '*    *   ***     *************************            *    *  *   BB*'
		 byte '*                DDGGGGGGGGGGGGGGGDDDDDDDD           *BBBB*BB*BBBBB*'
         byte '*********************************************************************' 



		 
main EQU start@0
.code
main PROC

; Get the Console standard output handle:
	INVOKE GetstdHandle, STD_OUTPUT_HANDLE				
	mov consoleHandle,eax
	push eax
	INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition
	mwrite "	Christmas is coming ,  but Santa Claus is kidnaped  ,  can you safe him ? "
	mov eax ,3000	
    call delay 
	call clrscr
     INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition
	 mWrite"              ---------SUPER   MARIO S---------       "
	mov eax,2500
	call delay
	pop eax
	call   GetMseconds
	call clrscr
    ;call WriteDec
	call crlf
	mov  startTime , eax
	;mov ecx,100	   		;max loop time(�ɶ��~�t���u�ʤ����Υi�H�[�ɶ�(?((�̤j�ɶ���)
	mov ebx,1000       		;1000milsecond	(1��)
	mov edi,60
	mov esi , offset barrier4	;�@�}�l�OMAP1
	mov MapNow,esi
   
call map
mov ecx ,17
show:
		mwrite <0ah>
		loop show
mwrite <0dh,"                                                   LV.1 -ThornsBarrier-                                               "> 
Initial:
	  mov dx, xyRestart.X
	  mov xyPosition.x,dx
	  mov dx, xyRestart.Y
	  mov xyPosition.Y,dx

START:
	;call ClrScr
	;call map
	call map
	call timerT	
	
	;INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
	mov eax, lightBlue  + white *16		;�`��W�I����
	call SetTextColor
	 ;mwrite "!@_@!" 
mov dx , xyPosition.x					;�N�Z���I�Z���[�_��
	mov decidex , dx
	mov dx , xyPosition.y
	mov decidey , dx
	sub decidex , 23					;�n��h��l��x=23
	movzx ecx , decidey					  
	mov ax , 0
.if ecx == 15			
jmp equal0
.endif

.if ecx == 3							;�ۨ�Ѫ�O,�[�^�ӥH�K�d��
add xyPosition.Y , 1
jmp draw
.endif
	sub ecx ,1 							;��h��lY=1
decide:
	add ax , 69							
loop decide								;�u�X�`�M
equal0:
add ax , decidex

.if esi==offset barrier4				;�Ĥ@���N�]

.IF score>400				;�Yscore�W�L20���A�L��
	  mwrite "                                               	 Enter LV.2 -SkyCastle-                                     "
	  mov eax ,2000				;���r�갱�d2��
	  call delay
	  mwrite <0dh,"                                               LV.2 -SkyCastle-                                               "> 
	  mov score,0
	  mov dx, xyRestart.X
	  mov xyPosition.x,dx
	  mov dx, xyRestart.Y
	  mov xyPosition.Y,dx
	  mov esi ,offset sky1
	  call GetMseconds
	  mov  startTime,eax
	  mov  edx,timer2
	  mov  timer ,edx
	  jmp START
	 .ENDIF


.if ([barrier4 + ax] == '*'||[barrier4 + ax-69] == '*'||[barrier4 + ax-138] == '*'||[barrier4 + ax-207] == '*')&& dir == 1
	;mWrite <"775",0dh,0ah>					 ;dir=1 ���V�W�� ,�P�_�U���A��
	;add xyPosition.Y , 1
	;jmp draw
.endif
.if [barrier4 + ax] == '*'&& dir == 2		;dir=2�����U   �A�Y���i���U�A�h�^����y��	
	;mWrite <"776",0dh,0ah>
	sub xyPosition.Y , 1
	jmp draw
.endif	
.if [barrier4 + ax] == '*'&& dir == 3		;dir=3���V��   �A�Y���i���ʡA�h�^����y��
	;mWrite <"777",0dh,0ah>
	add xyPosition.X , 1
	jmp draw
.endif
.if [barrier4 + ax] == '*'&& dir == 4		;dir=4���V�k   �A�Y���i�V�k�A�h�^����y��
	;mWrite <"778",0dh,0ah>
	sub xyPosition.X , 1
	jmp draw
.endif	
.if ([barrier4 + ax] == '*'||[barrier4 + ax-69] == '*'||[barrier4 + ax-138] == '*')&& dir == 5
	;add xyPosition.Y, 2					;;dir=5���k�W  �U���A���P�_
	;sub xyPosition.X, 1
	jmp draw
.ENDIF
.if ([barrier4 + ax] == '*'||[barrier4 + ax-69] == '*'||[barrier4 + ax-138] == '*')&& dir == 6
	;add xyPosition.Y, 2					;;dir=6�����W  �U���A���P�_
	;add xyPosition.X, 1
	jmp draw
.ENDIF

	
.if [barrier4 + ax-137] != '*'&& dir == 5				;-137 is -69*2+1(Y up 2, x right 1) ;��F�I�D��ê��
	push eax
	INVOKE WriteConsoleOutputCharacter,					;���N��誺��m�Ь��ť�
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count
		pop eax
		sub xyPosition.y,3
		.if [barrier4+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-138], ' '
	   .ENDIF
	   .if [barrier4+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-138], '*'
	   .ENDIF
		;call map 
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"									;�s�y�ݼv
		mov eax ,300									; ���n�묹 delay0.3��
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		pop eax
		add xyPosition.y,1								;�����̲צ�m
		add xyPosition.x,1
		.if [barrier4+ax-137]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-137], ' '
	   .ENDIF
	   .if [barrier4+ax-137]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-137]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-137]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-137], '*'
	   .ENDIF
	   
	  .IF [barrier4+ax-137+69]!='*'							;���O�ĪG�A*�~�i��
		m1: 
			cmp [barrier4+ax-137+69],'*' 
			je  m1end
			add  xyPosition.Y,1
			add ax ,69
			jmp m1
		 m1end:
	  .endIF
	  
.endif

.if [barrier4 + ax-139] != '*'&& dir == 6					;139 is Y up 2 ,X left 1 	;���ѦPdir=5 (�k�W�AE)
	push eax
INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
		pop eax
		sub xyPosition.y,3
		;call map 
		.if [barrier4+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-138], ' '
	   .ENDIF
	   .if [barrier4+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay	
		jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-138], '*'
	   .ENDIF
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"		
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		pop eax
		add xyPosition.y,1
		sub xyPosition.x,1
		.if [barrier4+ax-139]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-139], ' '
	   .ENDIF
	   .if [barrier4+ax-139]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-139]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
		mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-139]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-139], '*'
	   .ENDIF
		.IF [barrier4+ax-139+69]!='*'
		m2: 
			cmp [barrier4+ax-139+69],'*' 
			je  m2end
			add  xyPosition.Y,1
			add ax ,69
			jmp m2
		 m2end:
	  .endIF
.endif
.if [barrier4 + ax] != '*'&& dir == 4			
	 .if [barrier4+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax], ' '
	   .ENDIF
	   .if [barrier4+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
		mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax], '*'
	   .ENDIF
	sub xyPosition.X , 1	
	push eax
	INVOKE WriteConsoleOutputCharacter,				;�걼���y�Ъ���
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	add xyPosition.X , 1
	pop eax
	;mov [barrier4+ax],'A'
	.IF [barrier4+ax+69]!='*'
		m3: 
			cmp [barrier4+ax+69],'*' 
			je  m3end
			add  xyPosition.Y,1
			add ax ,69
			jmp m3
		 m3end:
	  .endIF
.endif

.if [barrier4 + ax] != '*'&& dir == 3				;��k�t���h
	 .if [barrier4+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax], ' '
	   .ENDIF
	   .if [barrier4+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
		mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax], '*'
	   .ENDIF
	add xyPosition.X , 1
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
      ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	sub xyPosition.X , 1
	pop eax
	;mov [barrier4+ax],'A'
	.IF [barrier4+ax+69]!='*'
		m4: 
			cmp [barrier4+ax+69],'*' 
			je  m4end
			add  xyPosition.Y,1
			add ax ,69
			jmp m4
		 m4end:
	  .endIF
.endif

.if [barrier4 + ax] != '*'&& dir == 2				;�򥪥k���t���h
	.if [barrier4+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax], ' '
	   .ENDIF
	   .if [barrier4+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax], '*'
	   .ENDIF
	sub xyPosition.Y , 1
	push  eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	add xyPosition.Y , 1
	pop eax
	;mov [barrier4+ax],'A'
	.IF [barrier4+ax+69]!='*'
		m5: 
			cmp [barrier4+ax+69],' ' 
			je  m5end
			add  xyPosition.Y,1
			add ax ,69
			jmp m5
		 m5end:
	  .endIF
.endif


.if [barrier4 + ax-69] != '*'&& dir == 1 
		 push eax
		 INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,											;�T�O�����׬���ê���H�U�A�̰����׬�3
       ADDR count
		pop eax
		.if [barrier4+ax-138]=='*'		 
		  sub xyPosition.Y, 1
		  .if [barrier4+ax-69]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-69], ' '
	   .ENDIF
	   .if [barrier4+ax-69]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-69]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-69]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-69], '*'
	   .ENDIF
		  mov T,1
		  jmp do
		 .endif 
		 .if [barrier4+ax-207]=='*'&&[barrier4+ax-138]!='*'
			.if [barrier4+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-138], ' '
	   .ENDIF
	   .if [barrier4+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-138], '*'
	   .ENDIF
			sub xyPosition.Y, 2
			mov T, 2
			jmp do 
		.endif
			.if[barrier4 + ax-138] != '*'&&[barrier4 + ax-207] != '*'
			.if [barrier4+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-138], ' '
	   .ENDIF
	   .if [barrier4+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-138], '*'
	   .ENDIF
			 .if [barrier4+ax-207]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [barrier4+ax-207], ' '
	   .ENDIF
	   .if [barrier4+ax-207]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [barrier4+ax-207]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [barrier4+ax-207]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [barrier4+ax-207], '*'
	   .ENDIF
			sub xyPosition.y,3
			mov T,3
			jmp do
		.endif
do : 
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		movzx ax,T
		add xyPosition.Y,ax 
		pop eax
		.IF [barrier4+ax+69]!='*'
		m6: 
			cmp [barrier4+ax+69],'*' 
			je  m6end
			add  xyPosition.Y,1
			add ax ,69
			jmp m6
		 m6end:
	  .endIF
			
	;INVOKE WriteConsoleOutputCharacter,
      ; outputHandle,
      ; ADDR space,   ; pointer to the bottom of the box
       ;1,
      ; xyPosition,
      ; ADDR count 
	;mov [barrier4+ax],'A'
.endif

.endif

.if esi == offset sky1

.IF score>40				;�Yscore�W�L10���A�L��
	  mwrite "                                                    Enter LV.3 -DivinityAltar-                   "
	  mov eax ,2000				;���r�갱�d2��
	  call delay
	  mwrite <0dh,"                                                      LV.3 -DivinityAltar-                                               "> 
	  mov score,0
	  mov dx, xyRestart.X
	  mov xyPosition.x,dx
	  mov dx, xyRestart.Y
	  mov xyPosition.Y,dx
	  mov esi ,offset map3
	  call GetMseconds
	  mov startTime,eax
	  mov edx,timer3
	  mov timer,edx
	  jmp START
	 .ENDIF
.if ([sky1+ax] == '*'||[sky1+ax-69] == '*'||[sky1+ax-138] == '*'||[sky1+ax-207] == '*')&& dir == 1
	;mWrite <"775",0dh,0ah>
	;add xyPosition.Y , 1
	;jmp draw
.endif
.if [sky1+ax] == '*'&& dir == 2
	;mWrite <"776",0dh,0ah>
	sub xyPosition.Y , 1
	jmp draw
.endif	
.if [sky1+ax] == '*'&& dir == 3
	;mWrite <"777",0dh,0ah>
	add xyPosition.X , 1
	jmp draw
.endif
.if [sky1+ax] == '*'&& dir == 4
	;mWrite <"778",0dh,0ah>
	sub xyPosition.X , 1
	jmp draw
.endif	
.if ([sky1+ax] == '*'||[sky1+ax-69] == '*'||[sky1+ax-138] == '*')&& dir == 5
	;add xyPosition.Y, 2
	;sub xyPosition.X, 1
	jmp draw
.ENDIF
.if ([sky1+ax] == '*'||[sky1+ax-69] == '*'||[sky1+ax-138] == '*')&& dir == 6
	;add xyPosition.Y, 2
	;add xyPosition.X, 1
	jmp draw
.ENDIF

	
.if [sky1+ax-137] != '*'&& dir == 5				;-137 is -69*2+1(Y up 2, x right 1) 
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count
		pop eax
		sub xyPosition.y,2
		.if [sky1+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-138], ' '
	   .ENDIF
	   .if [sky1+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-138], '*'
	   .ENDIF
		;call map 
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		pop eax
		;add xyPosition.y,1
		add xyPosition.x,1
		.if [sky1+ax-137]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-137], ' '
	   .ENDIF
	   .if [sky1+ax-137]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-137]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
		mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-137]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-137], '*'
	   .ENDIF
	   
	  .IF [sky1+ax-137+69]!='*'
		ms1: 
			cmp [sky1+ax-137+69],'*' 
			je  ms1end
			add  xyPosition.Y,1
			add ax ,69
			jmp ms1
		 ms1end:
	  .endIF
	  
.endif

.if [sky1+ax-139] != '*'&& dir == 6					;139 is Y up 2 ,X left 1 
	push eax
INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
		pop eax
		sub xyPosition.y,2
		;call map 
		.if [sky1+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-138], ' '
	   .ENDIF
	   .if [sky1+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-138], '*'
	   .ENDIF
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"		
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		pop eax
		;add xyPosition.y,1
		sub xyPosition.x,1
		.if [sky1+ax-139]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-139], ' '
	   .ENDIF
	   .if [sky1+ax-139]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-139]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-139]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-139], '*'
	   .ENDIF
		.IF [sky1+ax-139+69]!='*'
		ms2: 
			cmp [sky1+ax-139+69],'*' 
			je  ms2end
			add  xyPosition.Y,1
			add ax ,69
			jmp ms2
		 ms2end:
	  .endIF
.endif
.if [sky1+ax] != '*'&& dir == 4
	 .if [sky1+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax], ' '
	   .ENDIF
	   .if [sky1+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
		mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax], '*'
	   .ENDIF
	sub xyPosition.X , 1	
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	add xyPosition.X , 1
	pop eax
	;mov [sky1+ax],'A'
	.IF [sky1+ax+69]!='*'
		ms3: 
			cmp [sky1+ax+69],'*' 
			je  ms3end
			add  xyPosition.Y,1
			add ax ,69
			jmp ms3
		 ms3end:
	  .endIF
.endif

.if [sky1+ax] != '*'&& dir == 3
	 .if [sky1+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax], ' '
	   .ENDIF
	   .if [sky1+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	  mov eax , 3000
	   call Delay
		jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax], '*'
	   .ENDIF
	add xyPosition.X , 1
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
      ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	sub xyPosition.X , 1
	pop eax
	;mov [sky1+ax],'A'
	.IF [sky1+ax+69]!='*'
		ms4: 
			cmp [sky1+ax+69],'*' 
			je  ms4end
			add  xyPosition.Y,1
			add ax ,69
			jmp ms4
		 ms4end:
	  .endIF
.endif

.if [sky1+ax] != '*'&& dir == 2
	.if [sky1+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax], ' '
	   .ENDIF
	   .if [sky1+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax], '*'
	   .ENDIF
	sub xyPosition.Y , 1
	push  eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	add xyPosition.Y , 1
	pop eax
	;mov [sky1+ax],'A'
	.IF [sky1+ax+69]!='*'
		ms5: 
			cmp [sky1+ax+69],' ' 
			je  ms5end
			add  xyPosition.Y,1
			add ax ,69
			jmp ms5
		 ms5end:
	  .endIF
.endif


.if [sky1+ax-69] != '*'&& dir == 1 
		 push eax
		 INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count
		pop eax
		.if [sky1+ax-138]=='*'		 
		  sub xyPosition.Y, 1
		 .if [sky1+ax-69]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-69], ' '
	   .ENDIF
	   .if [sky1+ax-69]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-69]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-69]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-69], '*'
	   .ENDIF
		  mov T,1
		  jmp dos
		 .endif 
		 .if [sky1+ax-207]=='*'&&[sky1+ax-138]!='*'
			.if [sky1+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-138], ' '
	   .ENDIF
	   .if [sky1+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-138], '*'
	   .ENDIF
			sub xyPosition.Y, 2
			mov T, 2
			jmp dos 
		.endif
			.if[sky1+ax-138] != '*'&&[sky1+ax-207] != '*'
			.if [sky1+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-138], ' '
	   .ENDIF
	   .if [sky1+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-138], '*'
	   .ENDIF
			 .if [sky1+ax-207]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [sky1+ax-207], ' '
	   .ENDIF
	   .if [sky1+ax-207]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [sky1+ax-207]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [sky1+ax-207]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [sky1+ax-207], '*'
	   .ENDIF
			sub xyPosition.y,3
			mov T,3
			jmp dos
		.endif
dos: 
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		movzx ax,T
		add xyPosition.Y,ax 
		pop eax
		.IF [sky1+ax+69]!='*'
		ms6: 
			cmp [sky1+ax+69],'*' 
			je  ms6end
			add  xyPosition.Y,1
			add ax ,69
			jmp ms6
		 ms6end:
	  .endIF
			
	;INVOKE WriteConsoleOutputCharacter,
      ; outputHandle,
      ; ADDR space,   ; pointer to the bottom of the box
       ;1,
      ; xyPosition,
      ; ADDR count 
	;mov [sky1+ax],'A'
.endif

.endif





.if esi==offset map3
.IF score>30				;�Yscore�W�L10���A�L��
	  mwrite "      Santa Claus: You safe the world,warrior( !@_@! )! Merry X'mas and U will all pass in the semester~~       "
	  mov eax ,5000				;���r�갱�d2��
	  call delay
	  jmp END_FUNC
	 .ENDIF

.if ([map3+ax] == '*'||[map3+ax-69] == '*'||[map3+ax-138] == '*'||[map3+ax-207] == '*')&& dir == 1
	;mWrite <"775",0dh,0ah>
	;add xyPosition.Y , 1
	;jmp draw
.endif
.if [map3+ax] == '*'&& dir == 2
	;mWrite <"776",0dh,0ah>
	sub xyPosition.Y , 1
	jmp draw
.endif	
.if [map3+ax] == '*'&& dir == 3
	;mWrite <"777",0dh,0ah>
	add xyPosition.X , 1
	jmp draw
.endif
.if [map3+ax] == '*'&& dir == 4
	;mWrite <"778",0dh,0ah>
	sub xyPosition.X , 1
	jmp draw
.endif	
.if ([map3+ax] == '*'||[map3+ax-69] == '*'||[map3+ax-138] == '*')&& dir == 5
	;add xyPosition.Y, 2
	;sub xyPosition.X, 1
	jmp draw
.ENDIF
.if ([map3+ax] == '*'||[map3+ax-69] == '*'||[map3+ax-138] == '*')&& dir == 6
	;add xyPosition.Y, 2
	;add xyPosition.X, 1
	jmp draw
.ENDIF

	
.if [map3+ax-137] != '*'&& dir == 5				;-137 is -69*2+1(Y up 2, x right 1) 
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count
		pop eax
		sub xyPosition.y,3
		.if [map3+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-138], ' '
	   .ENDIF
	   .if [map3+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-138], '*'
	   .ENDIF
		;call map 
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		pop eax
		add xyPosition.y,1
		add xyPosition.x,1
		.if [map3+ax-137]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-137], ' '
	   .ENDIF
	   .if [map3+ax-137]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-137]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-137]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-137], '*'
	   .ENDIF
	   
	  .IF [map3+ax-137+69]!='*'
		m31: 
			cmp [map3+ax-137+69],'*' 
			je  m31end
			add  xyPosition.Y,1
			add ax ,69
			jmp m31
		 m31end:
	  .endIF
	  
.endif

.if [map3+ax-139] != '*'&& dir == 6					;139 is Y up 2 ,X left 1 
	push eax
INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
		pop eax
		sub xyPosition.y,3
		;call map 
		.if [map3+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-138], ' '
	   .ENDIF
	   .if [map3+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	  mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-138], '*'
	   .ENDIF
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"		
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		pop eax
		add xyPosition.y,1
		sub xyPosition.x,1
		.if [map3+ax-139]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-139], ' '
	   .ENDIF
	   .if [map3+ax-139]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-139]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-139]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-139], '*'
	   .ENDIF
		.IF [map3+ax-139+69]!='*'
		m32: 
			cmp [map3+ax-139+69],'*' 
			je  m32end
			add  xyPosition.Y,1
			add ax ,69
			jmp m32
		 m32end:
	  .endIF
.endif
.if [map3+ax] != '*'&& dir == 4
	 .if [map3+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax], ' '
	   .ENDIF
	   .if [map3+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	  mov eax , 3000
	   call Delay
		jmp END_FUNC
	   .ENDIF
	   .if [map3+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax], '*'
	   .ENDIF
	sub xyPosition.X , 1	
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	add xyPosition.X , 1
	pop eax
	;mov [map3+ax],'A'
	.IF [map3+ax+69]!='*'
		m33: 
			cmp [map3+ax+69],'*' 
			je  m33end
			add  xyPosition.Y,1
			add ax ,69
			jmp m33
		 m33end:
	  .endIF
.endif

.if [map3+ax] != '*'&& dir == 3
	 .if [map3+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax], ' '
	   .ENDIF
	   .if [map3+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	  mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [map3+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax], '*'
	   .ENDIF
	add xyPosition.X , 1
	push eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
      ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	sub xyPosition.X , 1
	pop eax
	;mov [map3+ax],'A'
	.IF [map3+ax+69]!='*'
		m34: 
			cmp [map3+ax+69],'*' 
			je  m34end
			add  xyPosition.Y,1
			add ax ,69
			jmp m34
		 m34end:
	  .endIF
.endif

.if [map3+ax] != '*'&& dir == 2
	.if [map3+ax]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax], ' '
	   .ENDIF
	   .if [map3+ax]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	  mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [map3+ax]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax], '*'
	   .ENDIF
	sub xyPosition.Y , 1
	push  eax
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count 
	add xyPosition.Y , 1
	pop eax
	;mov [map3+ax],'A'
	.IF [map3+ax+69]!='*'
		m35: 
			cmp [map3+ax+69],' ' 
			je  m35end
			add  xyPosition.Y,1
			add ax ,69
			jmp m35
		 m35end:
	  .endIF
.endif


.if [map3+ax-69] != '*'&& dir == 1 
		 push eax
		 INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR space,   ; pointer to the bottom of the box
       1,
       xyPosition,
       ADDR count
		pop eax
		.if [map3+ax-138]=='*'		 
		  sub xyPosition.Y, 1
		 .if [map3+ax-69]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-69], ' '
	   .ENDIF
	   .if [map3+ax-69]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-69]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	  mov eax , 3000
	   call Delay
	  jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-69]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-69], '*'
	   .ENDIF
		  mov T,1
		  jmp do3
		 .endif 
		 .if [map3+ax-207]=='*'&&[map3+ax-138]!='*'
			.if [map3+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-138], ' '
	   .ENDIF
	   .if [map3+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-138], '*'
	   .ENDIF
			sub xyPosition.Y, 2
			mov T, 2
			jmp do3 
		.endif
			.if[map3+ax-138] != '*'&&[map3+ax-207] != '*'
			.if [map3+ax-138]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-138], ' '
	   .ENDIF
	   .if [map3+ax-138]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-138]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   mov eax , 3000
	   call Delay
	   jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-138]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-138], '*'
	   .ENDIF
			 .if [map3+ax-207]=='G'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 10
	   mov [map3+ax-207], ' '
	   .ENDIF
	   .if [map3+ax-207]=='T'						;�Y�����W���L�{�����A�i�H�Y��
			jmp Initial
	   .ENDIF
	   .if [map3+ax-207]=='D'						;�Y�����W���L�{�����A�i�H�Y��
	   mwrite"               Santa Claus: (QQ) no leave me alone�@(!@_@!): !x_x!"
	   jmp END_FUNC
	   .ENDIF
	   .if [map3+ax-207]=='B'						;�Y�����W���L�{�����A�i�H�Y��
	   add score, 20
	   mov [map3+ax-207], '*'
	   .ENDIF
			sub xyPosition.y,3
			mov T,3
			jmp do3
		.endif
do3: 
		call timerT
		push eax
		mov eax, yellow  + black *16
		call SetTextColor
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		mwrite "!@_@!"
		mov eax ,300
		call delay
		INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition	
		call map;
		movzx ax,T
		add xyPosition.Y,ax 
		pop eax
		.IF [map3+ax+69]!='*'
		m36: 
			cmp [map3+ax+69],'*' 
			je  m36end
			add  xyPosition.Y,1
			add ax ,69
			jmp m36
		 m36end:
	  .endIF
			
	;INVOKE WriteConsoleOutputCharacter,
      ; outputHandle,
      ; ADDR space,   ; pointer to the bottom of the box
       ;1,
      ; xyPosition,
      ; ADDR count 
	;mov [map3+ax],'A'
.endif

.endif




draw:
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,									;���X �D��
       ADDR body,   ; pointer to the bottom of the box
       5,
       xyPosition,
       ADDR count	 
	 
	 
	 
	 
	call ReadChar
	.IF (ax == 1177h||ax==4800h) ;UP
		mov dir,1
		;call map 
	.ENDIF
	.IF (ax == 1f73h ||ax==5000h);DOWN
		
		add xyPosition.y,1
		mov dir ,2
	.ENDIF
	.IF (ax == 1e61h ||ax==4b00h);LEFT
		
		sub xyPosition.x,1
		mov dir ,3
	.ENDIF
	.IF (ax == 2064h||ax==4d00h );RIGHT
		
		add xyPosition.x,1
		mov dir ,4
	.ENDIF
	.IF(ax==1265h)				;E
		mov dir, 5
	.ENDIF
	.IF(ax==1071h)				;Q
		mov dir, 6
	.ENDIF	
	
	.IF ax == 0f09h ;TAB
		.IF esi== offset barrier4
			mwrite <0ah,"MAP_2:Sky Castle",0dh,0ah>
			mov esi, offset sky1
			mov MapNow,esi
			mov dir,0
		.elseif esi== offset sky1
			mov esi,offset map3
			mov MapNow,esi
			mwrite <0ah,"MAP_3:DivinityAltar",0dh,0ah>
			mov dir,0
			.elseif esi== offset map3
			mov esi,offset barrier4
			mov dir , 0
			mwrite  <0ah,"MAP_1:ThornsBarrier",0dh,0ah>
		.ENDIF
PASS:		
	.ENDIF
	.IF ax == 011Bh ;ESC
		jmp END_FUNC
	.ENDIF
	
	; �ˬd�@���W�U���k�ᦳ�S���W�L�������
	mov ax,xyBoundL.X
	.IF xyPosition.x <= ax ;x lowerbound
		add xyPosition.x,1    ; ���h�]�w��l
	.ENDIF
	mov ax,xyBoundR.x ; ���G�����������w�}�A�G�N�䤤�@���ন register
	.IF xyPosition.x >ax  ;x upperbound
		sub xyPosition.x,1
	.ENDIF
	mov ax, xyBoundL.Y
	.IF xyPosition.y <=ax ;y lowerbound
		add xyPosition.y,1
	.ENDIF
	mov ax,xyBoundR.y
	.IF xyPosition.y > ax ;y upperbound
		sub xyPosition.y,1
	.ENDIF
	
	jmp START
END_FUNC:
	call WaitMsg
	call crlf
	exit
main ENDP


timerT PROC 
	pushad
	push xyPosition
	push eax
	mov eax, black +lightGray*16
	call SetTextColor					;push eax
	pop eax
	mov ax,xyMap.x
	mov xyPosition.x,ax
	mov ax,xyMap.y
	mov xyPosition.y,ax	
	INVOKE SetConsoleCursorPosition ,consoleHandle, xyPosition
	mwrite<0ah,"SCORE: ">
	push eax
	movzx eax,score
	call WriteDec
	pop eax
	
	mwrite <0ah,"*********************",0ah,"*ur body is the left*",0ah,"*most character!!   *",0ah,"*********************">
	
	mWrite  <0ah,"Help:",0ah," ","q,��:jump in place",0ah," ","a,��: left",0ah," ","s,��: down",0ah," ","d,��: right",0ah," ","q: ��",0ah," ","e: ��",0ah," ","ESC:end the game">	
	mWrite<0ah, " Tab: change maps">
	mwrite <0ah," G: money ",0ah," B: DangerousBonus",0ah," T: trap",0ah," D: death">
L1:
	call   GetMseconds		;���o��Ǯɶ�(��쬰milsec
    push  ebx
    ;call WriteDec
	mov   ebx,eax
	sub   eax , startTime        
	sub   ebx,esi
	.IF ebx>1500
		mov esi,ebx
		pop ebx
		jmp pr
	.ENDIF
	pop ebx
	jmp pause
pr:	
	xor edx,edx
	idiv ebx			;�ഫ��쬰��
	sub eax,timer			;�p��O�˼Ʈɶ�(���d�ɶ�-�g�L�ɶ�)
	neg eax
	mov i,eax
	call turnback			; 0dh
	INVOKE buildclockType,i		;i���`�ɶ�(��)
	xor edx,edx			
	idiv edi			;eax����,edx����						
	push eax
	mov eax,edx			;�L�X���
	call WriteDec
	pop eax
	mWrite " second left"
	cmp eax,0 		;�Yeax,edx�Ҭ�0--->i��0,����
		jz L_T
	jmp pause	
L_T:
	cmp edx,0
	jz L2
	jmp pause	

L2:		
	call crlf
	mWrite "Time is out!"
	
L3:
	call crlf
	call WaitMsg
pause:
	pop xyPosition	
	popad	
	ret
timerT ENDP


turnback PROC	
	mWrite 0dh
	ret 
turnback ENDP


buildclockType PROC,
	judge:dword
	push edx
	push eax 
	xor edx,edx		
	mov eax,judge				
	idiv edi		;eax��min,edx��sec		
	cmp eax,0		
	jz Lv1			;�Ymin==0
	jmp Lv2			;�Ymin>0
Lv1:	
	mWrite "00:"	
	mov eax,judge
	sub eax,10		;�p��10��A�h�L�@��0(�p��Q���eax-10��1xxxxxxxb(overflow))
	test eax,0FF00h		
	jnz Print0		 
	jmp GO
Print0:
	push eax
	mov eax,0
	call WriteDec
	pop eax
	jmp GO
Lv2:
	mwrite "!@_@!"
	;mov eax,1
	.IF eax>8000h
	 jmp specialcase
	.ENDIF 
	call WriteDec
	xor edx,edx
	mWrite ":"
	mov eax,judge
	sub eax,70		;eax-70(1min+10sec)
	test eax,8000h
	jnz Print0
	jmp GO
specialcase:
			mWrite <"time overflow",0ah>
			call WaitMsg
			exit
GO:	
	pop eax
	pop edx
	ret 
buildclockType ENDP




map PROC
    pushad	
	push xyPosition							;�L�X�~�ز�
	INITIAL:
	mov ax,xyInit.x
	mov xyPosition.x,ax
	mov ax,xyInit.y
	mov xyPosition.y,ax	
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE ; Get the console ouput handle
    mov outputHandle, eax ; save console handle
    ;call Clrscr
    ; �e�Xbox���Ĥ@��
 
    INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes0,
      Map_Width,
      xyPosition,
      ADDR bytesWritten
 
    INVOKE WriteConsoleOutputCharacter,
       outputHandle,   ; console output handle
       ADDR MAP_TOP,   ; pointer to the top box line
       Map_Width,   ; size of box line
       xyPosition,   ; coordinates of first char
       ADDR count    ; output count
 
    inc xyPosition.Y   ; �y�д���U�@���m
 
    mov ecx, (Map_Height)    ; number of lines in body
 
L1:
	push ecx  ; save counter �קKinvoke ���ϥΨ�o�ӼȦs��
    INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes1,
      Map_Width,
      xyPosition,
      ADDR bytesWritten
   
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR MAP_MID,   ; pointer to the box body
       Map_Width,
       xyPosition,
       ADDR count 
 
		inc xyPosition.Y   ; next line
		pop ecx   ; restore counter
    loop L1   
	INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes2,
      Map_Width,
      xyPosition,
      ADDR bytesWritten
		; draw bottom of the box	
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR MAP_BOT,   ; pointer to the bottom of the box
       Map_Width,
       xyPosition,
       ADDR count 

	   
	mov xyPosition.X ,23 
	mov xyPosition.Y , 1	
	mov ecx , 15
	
mapB:									;�L�X�a�ϥD��
	push ecx
	INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       esi,   ; pointer to the box body
       Map_Width-2,
       xyPosition,
       ADDR count 
	add esi , 69					;����U�@��
	inc xyPosition.Y				;�y�Ф]����U�@��
	pop ecx
	loop mapB
	pop xyPosition
	popad	
	ret
map ENDP
 

END main

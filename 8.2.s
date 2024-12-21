# gcc -no-pie -o 8.2 8.2.s
# ./8.2

.global main

init:
        pushq   %rbp
        movq    %rsp, %rbp
        pushq   %rbx
        subq    $24, %rsp
        movq    %rdi, -24(%rbp)
        movl    %esi, %eax
        movw    %ax, -28(%rbp)
        movl    $16, %edi
        call    malloc
        movq    %rax, %rdx
        movq    -24(%rbp), %rax
        movq    %rdx, (%rax)
        movq    -24(%rbp), %rax
        movq    (%rax), %rax
        movl    $0, 8(%rax)
        movq    -24(%rbp), %rax
        movq    (%rax), %rax
        movl    $10, 12(%rax)
        movzwl  -28(%rbp), %edx
        movl    %edx, %eax
        sall    $2, %eax
        addl    %edx, %eax
        addl    %eax, %eax
        cltq
        movq    -24(%rbp), %rdx
        movq    (%rdx), %rbx
        movq    %rax, %rdi
        call    malloc
        movq    %rax, (%rbx)
        nop
        movq    -8(%rbp), %rbx
        leave
        ret
append:
        pushq   %rbp
        movq    %rsp, %rbp
        pushq   %rbx
        subq    $56, %rsp
        movq    %rdi, -56(%rbp)
        movq    %rsi, -64(%rbp)
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        testq   %rax, %rax
        jne     .L3
        movq    -56(%rbp), %rax
        movl    $6, %esi
        movq    %rax, %rdi
        call    init
.L3:
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        movl    8(%rax), %eax
        movl    %eax, -20(%rbp)
        movl    -20(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -24(%rbp)
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        movq    (%rax), %rax
        movq    %rax, -32(%rbp)
        movl    -24(%rbp), %eax
        cmpl    -20(%rbp), %eax
        jne     .L4
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        movl    12(%rax), %edx
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        addl    %edx, %edx
        movl    %edx, 12(%rax)
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        movl    12(%rax), %eax
        movl    %eax, -36(%rbp)
        movl    -36(%rbp), %edx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -56(%rbp), %rax
        movq    (%rax), %rbx
        movq    -32(%rbp), %rax
        movq    %rdx, %rsi
        movq    %rax, %rdi
        call    realloc
        movq    %rax, (%rbx)
.L4:
        movl    -20(%rbp), %edx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -32(%rbp), %rax
        addq    %rdx, %rax
        movl    -64(%rbp), %edx
        movl    %edx, (%rax)
        movzwl  -60(%rbp), %edx
        movw    %dx, 4(%rax)
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        movl    -24(%rbp), %edx
        movl    %edx, 8(%rax)
        nop
        movq    -8(%rbp), %rbx
        leave
        ret
printa:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $32, %rsp
        movq    %rdi, %rax
        movq    %rsi, %rcx
        movq    %rax, %rax
        movl    $0, %edx
        movq    %rcx, %rdx
        movq    %rax, -32(%rbp)
        movq    %rdx, -24(%rbp)
        movq    -32(%rbp), %rax
        movq    %rax, -16(%rbp)
        movl    -24(%rbp), %eax
        movl    %eax, %esi
        movl    $0, %eax
        movl    $0, -4(%rbp)
        jmp     .L6
.L8:
        cmpl    $0, -4(%rbp)
        jne     .L7
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        movzbl  (%rax), %eax
        movsbl  %al, %eax
        movl    %eax, %esi
        movl    $0, %eax
.L7:
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        movswl  %ax, %ecx
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        cwtl
        movl    %ecx, %edx
        movl    %eax, %esi
        movl    $0, %eax
        addl    $1, -4(%rbp)
.L6:
        movl    -24(%rbp), %eax
        movl    -4(%rbp), %edx
        cmpl    %eax, %edx
        jb      .L8
        movl    $10, %edi
        nop
        leave
        ret
abs:
        pushq   %rbp
        movq    %rsp, %rbp
        movl    %edi, -4(%rbp)
        movl    -4(%rbp), %eax
        movl    %eax, %edx
        negl    %edx
        cmovns  %edx, %eax
        popq    %rbp
        ret
absd:
        pushq   %rbp
        movq    %rsp, %rbp
        movq    %rdi, -24(%rbp)
        movq    %rsi, -32(%rbp)
        movzbl  -24(%rbp), %eax
        movb    %al, -12(%rbp)
        movzwl  -30(%rbp), %eax
        movl    %eax, %edx
        movzwl  -22(%rbp), %eax
        movl    %eax, %ecx
        movl    %edx, %eax
        subl    %ecx, %eax
        movw    %ax, -10(%rbp)
        movzwl  -28(%rbp), %eax
        movl    %eax, %edx
        movzwl  -20(%rbp), %eax
        movl    %eax, %ecx
        movl    %edx, %eax
        subl    %ecx, %eax
        movw    %ax, -8(%rbp)
        movl    -12(%rbp), %eax
        movl    %eax, -6(%rbp)
        movzwl  -8(%rbp), %eax
        movw    %ax, -2(%rbp)
        movl    $0, %eax
        movl    -6(%rbp), %edx
        movl    %edx, %edx
        movabsq $-4294967296, %rcx
        andq    %rcx, %rax
        orq     %rdx, %rax
        movzwl  -2(%rbp), %edx
        movzwl  %dx, %edx
        salq    $32, %rdx
        movabsq $-281470681743361, %rcx
        andq    %rcx, %rax
        orq     %rdx, %rax
        popq    %rbp
        ret
buildb:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $32, %rsp
        movq    %rdi, -24(%rbp)
        movq    %rsi, -32(%rbp)
        movl    $0, -4(%rbp)
        jmp     .L14
.L17:
        movl    $0, -8(%rbp)
        jmp     .L15
.L16:
        movq    -24(%rbp), %rax
        movq    %rax, %rdi
        call    fgetc
        movl    %eax, %ecx
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -32(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq
        movb    %cl, (%rdx,%rax)
        addl    $1, -8(%rbp)
.L15:
        cmpl    $49, -8(%rbp)
        jle     .L16
        movq    -24(%rbp), %rax
        movq    %rax, %rdi
        call    fgetc
        addl    $1, -4(%rbp)
.L14:
        cmpl    $49, -4(%rbp)
        jle     .L17
        nop
        nop
        leave
        ret
printb:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $32, %rsp
        movq    %rdi, -24(%rbp)
        movl    $0, -4(%rbp)
        jmp     .L19
.L22:
        movl    $0, -8(%rbp)
        jmp     .L20
.L21:
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq
        movzbl  (%rdx,%rax), %eax
        movsbl  %al, %eax
        movl    %eax, %edi
        
        addl    $1, -8(%rbp)
.L20:
        cmpl    $49, -8(%rbp)
        jle     .L21
        movl    $10, %edi
        addl    $1, -4(%rbp)
.L19:
        cmpl    $49, -4(%rbp)
        jle     .L22
        nop
        nop
        leave
        ret
isa:
        pushq   %rbp
        movq    %rsp, %rbp
        movl    %edi, %eax
        movb    %al, -4(%rbp)
        cmpb    $96, -4(%rbp)
        jle     .L24
        cmpb    $122, -4(%rbp)
        jle     .L25
.L24:
        cmpb    $64, -4(%rbp)
        jle     .L26
        cmpb    $90, -4(%rbp)
        jle     .L25
.L26:
        cmpb    $47, -4(%rbp)
        jle     .L27
        cmpb    $57, -4(%rbp)
        jg      .L27
.L25:
        movl    $1, %eax
        jmp     .L29
.L27:
        movl    $0, %eax
.L29:
        popq    %rbp
        ret
geta:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $32, %rsp
        movq    %rdi, -24(%rbp)
        movq    %rsi, -32(%rbp)
        movl    $0, -4(%rbp)
        jmp     .L31
.L38:
        movl    $0, -8(%rbp)
        jmp     .L32
.L37:
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq
        movzbl  (%rdx,%rax), %eax
        cbtw
        movw    %ax, -10(%rbp)
        movzwl  -10(%rbp), %eax
        movsbl  %al, %eax
        movl    %eax, %edi
        call    isa
        testl   %eax, %eax
        je      .L39
        movswq  -10(%rbp), %rax
        leaq    0(,%rax,8), %rdx
        movq    -32(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        testq   %rax, %rax
        jne     .L35
        movswq  -10(%rbp), %rax
        leaq    0(,%rax,8), %rdx
        movq    -32(%rbp), %rax
        addq    %rdx, %rax
        movl    $6, %esi
        movq    %rax, %rdi
        call    init
.L35:
        movzwl  -10(%rbp), %eax
        movb    %al, -16(%rbp)
        movl    -8(%rbp), %eax
        movw    %ax, -14(%rbp)
        movl    -4(%rbp), %eax
        movw    %ax, -12(%rbp)
        movswq  -10(%rbp), %rax
        leaq    0(,%rax,8), %rdx
        movq    -32(%rbp), %rax
        addq    %rdx, %rax
        movq    -16(%rbp), %rsi
        movq    %rax, %rdi
        call    append
        jmp     .L36
.L39:
        nop
.L36:
        addl    $1, -8(%rbp)
.L32:
        cmpl    $49, -8(%rbp)
        jle     .L37
        addl    $1, -4(%rbp)
.L31:
        cmpl    $49, -4(%rbp)
        jle     .L38
        nop
        nop
        leave
        ret
getdist:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $48, %rsp
        movq    %rdi, -40(%rbp)
        movq    %rsi, -48(%rbp)
        movl    $0, -4(%rbp)
        jmp     .L41
.L49:
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        testq   %rax, %rax
        je      .L50
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        movl    8(%rax), %eax
        cmpl    $1, %eax
        je      .L50
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        movq    (%rax), %rax
        movq    %rax, -24(%rbp)
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        movq    (%rax), %rdx
        movq    8(%rax), %rax
        movq    %rdx, %rdi
        movq    %rax, %rsi
        movl    $0, -8(%rbp)
        jmp     .L45
.L48:
        movl    -8(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -12(%rbp)
        jmp     .L46
.L47:
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        movslq  %eax, %rcx
        movq    %rcx, %rax
        addq    %rax, %rax
        addq    %rcx, %rax
        addq    %rax, %rax
        movq    %rax, %rcx
        movq    -24(%rbp), %rax
        addq    %rcx, %rax
        movzwl  (%rdx), %ecx
        movzwl  2(%rdx), %esi
        salq    $16, %rsi
        orq     %rsi, %rcx
        movzwl  4(%rdx), %edx
        salq    $32, %rdx
        orq     %rcx, %rdx
        movq    %rdx, %rsi
        movzwl  (%rax), %edx
        movzwl  2(%rax), %ecx
        salq    $16, %rcx
        orq     %rcx, %rdx
        movzwl  4(%rax), %eax
        salq    $32, %rax
        orq     %rdx, %rax
        movq    %rax, %rdi
        call    absd
        movw    %ax, -30(%rbp)
        movq    %rax, %rdx
        shrq    $16, %rdx
        andb    $-1, %dh
        movw    %dx, -28(%rbp)
        shrq    $32, %rax
        andb    $-1, %ah
        movw    %ax, -26(%rbp)
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  -30(%rbp), %edx
        movzwl  -28(%rbp), %ecx
        salq    $16, %rcx
        orq     %rdx, %rcx
        movzwl  -26(%rbp), %edx
        salq    $32, %rdx
        orq     %rcx, %rdx
        movq    %rdx, %rsi
        movq    %rax, %rdi
        call    append
        addl    $1, -12(%rbp)
.L46:
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        movl    8(%rax), %eax
        movl    -12(%rbp), %edx
        cmpl    %eax, %edx
        jb      .L47
        addl    $1, -8(%rbp)
.L45:
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        movl    8(%rax), %eax
        subl    $1, %eax
        movl    -8(%rbp), %edx
        cmpl    %eax, %edx
        jb      .L48
        movl    -4(%rbp), %eax
        cltq
        leaq    0(,%rax,8), %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movq    (%rax), %rax
        movq    (%rax), %rdx
        movq    8(%rax), %rax
        movq    %rdx, %rdi
        movq    %rax, %rsi
        jmp     .L44
.L50:
        nop
.L44:
        addl    $1, -4(%rbp)
.L41:
        cmpl    $254, -4(%rbp)
        jle     .L49
        nop
        nop
        leave
        ret
inbound:
        pushq   %rbp
        movq    %rsp, %rbp
        movq    %rdi, -8(%rbp)
        movzwl  -6(%rbp), %eax
        testw   %ax, %ax
        js      .L52
        movzwl  -4(%rbp), %eax
        testw   %ax, %ax
        js      .L52
        movzwl  -6(%rbp), %eax
        cmpw    $49, %ax
        jg      .L52
        movzwl  -4(%rbp), %eax
        cmpw    $49, %ax
        jg      .L52
        movl    $1, %eax
        jmp     .L54
.L52:
        movl    $0, %eax
.L54:
        popq    %rbp
        ret
.LC3:
        .string "r"
.LC4:
        .string "input/8.txt"
.LC5:
        .string "Missing input file"
.LC7:
        .string "%d\n"
main:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $6672, %rsp
        leaq    -4608(%rbp), %rdx
        movl    $0, %eax
        movl    $255, %ecx
        movq    %rdx, %rdi
        rep stosq
        leaq    -6656(%rbp), %rdx
        movl    $0, %eax
        movl    $255, %ecx
        movq    %rdx, %rdi
        rep stosq
        movl    $.LC3, %esi
        movl    $.LC4, %edi
        call    fopen
        movq    %rax, -32(%rbp)
        cmpq    $0, -32(%rbp)
        jne     .L56
        movl    $.LC5, %edi
        call    perror
        movl    $-1, %eax
        jmp     .L77
.L56:
        movl    $0, -4(%rbp)
        leaq    -2560(%rbp), %rdx
        movq    -32(%rbp), %rax
        movq    %rdx, %rsi
        movq    %rax, %rdi
        call    buildb
        leaq    -2560(%rbp), %rax
        movq    %rax, %rdi
        call    printb
        leaq    -4608(%rbp), %rdx
        leaq    -2560(%rbp), %rax
        movq    %rdx, %rsi
        movq    %rax, %rdi
        call    geta
        leaq    -6656(%rbp), %rdx
        leaq    -4608(%rbp), %rax
        movq    %rdx, %rsi
        movq    %rax, %rdi
        call    getdist
        movl    $0, -8(%rbp)
        jmp     .L58
.L72:
        movl    -8(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        testq   %rax, %rax
        je      .L78
        movl    -8(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        movl    8(%rax), %eax
        cmpl    $1, %eax
        je      .L78
        movl    $0, -12(%rbp)
        movl    -8(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        movq    (%rax), %rax
        movq    %rax, -40(%rbp)
        movl    -8(%rbp), %eax
        cltq
        movq    -6656(%rbp,%rax,8), %rax
        movq    (%rax), %rax
        movq    %rax, -48(%rbp)
        movl    -8(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        movl    8(%rax), %edx
        movl    -4(%rbp), %eax
        addl    %edx, %eax
        movl    %eax, -4(%rbp)
        movl    $0, -16(%rbp)
        jmp     .L62
.L71:
        movl    -16(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -20(%rbp)
        jmp     .L63
.L70:
        movb    $35, -6662(%rbp)
        movl    -16(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        movl    %eax, %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        movl    %eax, %edx
        movl    %ecx, %eax
        subl    %edx, %eax
        movw    %ax, -6660(%rbp)
        movl    -16(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        movl    %eax, %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        movl    %eax, %edx
        movl    %ecx, %eax
        subl    %edx, %eax
        movw    %ax, -6658(%rbp)
        movb    $35, -6668(%rbp)
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        movl    %eax, %ecx
        movl    -20(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        addl    %ecx, %eax
        movw    %ax, -6666(%rbp)
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        movl    %eax, %ecx
        movl    -20(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        addl    %ecx, %eax
        movw    %ax, -6664(%rbp)
        movl    -16(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -40(%rbp), %rax
        addq    %rdx, %rax
        movzbl  (%rax), %eax
        movb    %al, -49(%rbp)
        jmp     .L64
.L66:
        movzwl  -6658(%rbp), %eax
        cwtl
        movzwl  -6660(%rbp), %edx
        movswl  %dx, %edx
        movslq  %edx, %rcx
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        addq    %rbp, %rax
        addq    %rcx, %rax
        subq    $2560, %rax
        movzbl  (%rax), %eax
        cmpb    $46, %al
        jne     .L65
        addl    $1, -4(%rbp)
        movzwl  -6658(%rbp), %eax
        cwtl
        movzwl  -6660(%rbp), %edx
        movswl  %dx, %edx
        movzbl  -6662(%rbp), %ecx
        movslq  %edx, %rsi
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        addq    %rbp, %rax
        addq    %rsi, %rax
        subq    $2560, %rax
        movb    %cl, (%rax)
.L65:
        movzwl  -6660(%rbp), %eax
        movl    %eax, %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        movl    %eax, %edx
        movl    %ecx, %eax
        subl    %edx, %eax
        movw    %ax, -6660(%rbp)
        movzwl  -6658(%rbp), %eax
        movl    %eax, %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        movl    %eax, %edx
        movl    %ecx, %eax
        subl    %edx, %eax
        movw    %ax, -6658(%rbp)
.L64:
        movzwl  -6662(%rbp), %eax
        movzwl  -6660(%rbp), %edx
        salq    $16, %rdx
        orq     %rax, %rdx
        movzwl  -6658(%rbp), %eax
        salq    $32, %rax
        orq     %rdx, %rax
        movq    %rax, %rdi
        call    inbound
        testl   %eax, %eax
        jne     .L66
        jmp     .L67
.L69:
        movzwl  -6664(%rbp), %eax
        cwtl
        movzwl  -6666(%rbp), %edx
        movswl  %dx, %edx
        movslq  %edx, %rcx
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        addq    %rbp, %rax
        addq    %rcx, %rax
        subq    $2560, %rax
        movzbl  (%rax), %eax
        cmpb    $46, %al
        jne     .L68
        addl    $1, -4(%rbp)
        movzwl  -6664(%rbp), %eax
        cwtl
        movzwl  -6666(%rbp), %edx
        movswl  %dx, %edx
        movzbl  -6668(%rbp), %ecx
        movslq  %edx, %rsi
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        addq    %rax, %rax
        addq    %rbp, %rax
        addq    %rsi, %rax
        subq    $2560, %rax
        movb    %cl, (%rax)
.L68:
        movzwl  -6666(%rbp), %eax
        movl    %eax, %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  2(%rax), %eax
        addl    %ecx, %eax
        movw    %ax, -6666(%rbp)
        movzwl  -6664(%rbp), %eax
        movl    %eax, %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        addq    %rax, %rax
        addq    %rdx, %rax
        addq    %rax, %rax
        movq    %rax, %rdx
        movq    -48(%rbp), %rax
        addq    %rdx, %rax
        movzwl  4(%rax), %eax
        addl    %ecx, %eax
        movw    %ax, -6664(%rbp)
        cmpb    $65, -49(%rbp)
        jne     .L67
        movzwl  -6664(%rbp), %eax
        movswl  %ax, %edx
        movzwl  -6666(%rbp), %eax
        cwtl
        movl    %eax, %esi
        movl    $0, %eax
.L67:
        movl    -6668(%rbp), %eax
        movzwl  -6664(%rbp), %edx
        salq    $32, %rdx
        orq     %rdx, %rax
        movq    %rax, %rdi
        call    inbound
        testl   %eax, %eax
        jne     .L69
        addl    $1, -12(%rbp)
        addl    $1, -20(%rbp)
.L63:
        movl    -8(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        movl    8(%rax), %eax
        movl    -20(%rbp), %edx
        cmpl    %eax, %edx
        jb      .L70
        addl    $1, -16(%rbp)
.L62:
        movl    -8(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        movl    8(%rax), %eax
        subl    $1, %eax
        movl    -16(%rbp), %edx
        cmpl    %eax, %edx
        jb      .L71
        jmp     .L61
.L78:
        nop
.L61:
        addl    $1, -8(%rbp)
.L58:
        cmpl    $254, -8(%rbp)
        jle     .L72
        leaq    -2560(%rbp), %rax
        movq    %rax, %rdi
        call    printb
        movl    -4(%rbp), %eax
        movl    %eax, %esi
        movl    $.LC7, %edi
        movl    $0, %eax
        call    printf
        movl    $0, -24(%rbp)
        jmp     .L73
.L76:
        movl    -24(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        testq   %rax, %rax
        je      .L74
        movl    -24(%rbp), %eax
        cltq
        movq    -4608(%rbp,%rax,8), %rax
        movq    %rax, %rdi
        call    free
.L74:
        movl    -24(%rbp), %eax
        cltq
        movq    -6656(%rbp,%rax,8), %rax
        testq   %rax, %rax
        je      .L75
        movl    -24(%rbp), %eax
        cltq
        movq    -6656(%rbp,%rax,8), %rax
        movq    %rax, %rdi
        call    free
.L75:
        addl    $1, -24(%rbp)
.L73:
        cmpl    $254, -24(%rbp)
        jle     .L76
        movq    -32(%rbp), %rax
        movq    %rax, %rdi
        call    fclose
        movl    $0, %eax
.L77:
        leave
        ret

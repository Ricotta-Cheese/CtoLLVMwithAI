; ModuleID = 'source.c'
source_filename = "source.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx27.2.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @compute(i32 noundef %x, i32 noundef %y) #0 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %acc = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %y, ptr %y.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %y.addr, align 4
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %2, %3
  store i32 %sub, ptr %acc, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %x.addr, align 4
  %and = and i32 %5, 15
  %6 = load i32, ptr %y.addr, align 4
  %and1 = and i32 %6, 1
  %add = add i32 %and, %and1
  %cmp = icmp ult i32 %4, %add
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32, ptr %acc, align 4
  %8 = load i32, ptr %i, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %xor2 = xor i32 %9, 3
  store i32 %xor2, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %sub3 = sub i32 %11, 1166739319
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %sub4 = sub i32 %12, %13
  %mul = mul i32 %sub3, %sub4
  %xor5 = xor i32 %10, %mul
  store i32 %xor5, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %16
  %and8 = and i32 %xor7, 256
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %or = or i32 31, %19
  %add10 = add i32 %18, %or
  %xor11 = xor i32 %17, %add10
  store i32 %xor11, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %xor12 = xor i32 %21, %22
  %xor13 = xor i32 %20, %xor12
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %x.addr, align 4
  %xor14 = xor i32 %24, %25
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %i, align 4
  %add15 = add i32 %26, %27
  %add16 = add i32 %xor14, %add15
  %28 = load i32, ptr %x.addr, align 4
  %add17 = add i32 %add16, %28
  %xor18 = xor i32 %23, %add17
  store i32 %xor18, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %shr = lshr i32 %30, 1
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %acc, align 4
  %or19 = or i32 %31, %32
  %shr20 = lshr i32 %or19, 7
  %and21 = and i32 %shr, %shr20
  %xor22 = xor i32 %29, %and21
  store i32 %xor22, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %33 = load i32, ptr %i, align 4
  %inc = add i32 %33, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %34 = load i32, ptr %x.addr, align 4
  %35 = load i32, ptr %y.addr, align 4
  %xor23 = xor i32 %34, %35
  %and24 = and i32 %xor23, 256
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else28

if.then26:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %36, %37
  store i32 %xor27, ptr %acc, align 4
  br label %if.end32

if.else28:                                        ; preds = %for.end
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %y.addr, align 4
  %xor29 = xor i32 -1, %39
  %xor30 = xor i32 %38, %xor29
  store i32 %xor30, ptr %acc, align 4
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %x.addr, align 4
  %xor31 = xor i32 %40, %41
  store i32 %xor31, ptr %acc, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.else28, %if.then26
  %42 = load i32, ptr %acc, align 4
  ret i32 %42
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 27, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}

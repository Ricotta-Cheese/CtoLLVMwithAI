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
  %8 = load i32, ptr %x.addr, align 4
  %9 = load i32, ptr %x.addr, align 4
  %or = or i32 %8, %9
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %add2 = add i32 %10, %11
  %or3 = or i32 %or, %add2
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %mul = mul i32 %12, %13
  %shr = lshr i32 %mul, 17
  %sub4 = sub i32 %or3, %shr
  %xor = xor i32 %7, %sub4
  store i32 %xor, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %16
  %and7 = and i32 %xor6, 268435456
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %xor9 = xor i32 %17, 131072
  store i32 %xor9, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %y.addr, align 4
  %20 = load i32, ptr %y.addr, align 4
  %or10 = or i32 %19, %20
  %21 = load i32, ptr %i, align 4
  %22 = load i32, ptr %y.addr, align 4
  %or11 = or i32 %21, %22
  %xor12 = xor i32 %or10, %or11
  %xor13 = xor i32 %18, %xor12
  store i32 %xor13, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %and14 = and i32 %24, %25
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %x.addr, align 4
  %or15 = or i32 %26, %27
  %add16 = add i32 %and14, %or15
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %i, align 4
  %sub17 = sub i32 %28, %29
  %shr18 = lshr i32 %sub17, 31
  %and19 = and i32 %add16, %shr18
  %xor20 = xor i32 %23, %and19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %30 = load i32, ptr %i, align 4
  %inc = add i32 %30, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %y.addr, align 4
  %xor21 = xor i32 %31, %32
  %and22 = and i32 %xor21, 8
  %cmp23 = icmp eq i32 %and22, 0
  br i1 %cmp23, label %if.then24, label %if.else26

if.then24:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %xor25 = xor i32 %33, 2
  store i32 %xor25, ptr %acc, align 4
  br label %if.end28

if.else26:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %xor27 = xor i32 %34, %35
  store i32 %xor27, ptr %acc, align 4
  br label %if.end28

if.end28:                                         ; preds = %if.else26, %if.then24
  %36 = load i32, ptr %acc, align 4
  ret i32 %36
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

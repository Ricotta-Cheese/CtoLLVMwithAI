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
  %8 = load i32, ptr %acc, align 4
  %mul = mul i32 7, %8
  %xor = xor i32 %7, %mul
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %y.addr, align 4
  %11 = load i32, ptr %acc, align 4
  %and2 = and i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %13 = load i32, ptr %i, align 4
  %xor3 = xor i32 %12, %13
  %add4 = add i32 %and2, %xor3
  %xor5 = xor i32 %9, %add4
  store i32 %xor5, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %16
  %and8 = and i32 %xor7, 1
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %y.addr, align 4
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %y.addr, align 4
  %21 = load i32, ptr %i, align 4
  %or = or i32 %20, %21
  %and10 = and i32 %19, %or
  %or11 = or i32 %18, %and10
  %xor12 = xor i32 %17, %or11
  store i32 %xor12, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %y.addr, align 4
  %and13 = and i32 %23, 7
  %xor14 = xor i32 %22, %and13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %y.addr, align 4
  %and15 = and i32 %25, %26
  %shl = shl i32 %and15, 18
  %xor16 = xor i32 %24, %shl
  store i32 %xor16, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %or17 = or i32 %28, -1169162598
  %shr = lshr i32 %or17, 18
  %29 = load i32, ptr %y.addr, align 4
  %30 = load i32, ptr %acc, align 4
  %and18 = and i32 %29, %30
  %31 = load i32, ptr %acc, align 4
  %shr19 = lshr i32 %31, 24
  %or20 = or i32 %and18, %shr19
  %sub21 = sub i32 %shr, %or20
  %xor22 = xor i32 %27, %sub21
  store i32 %xor22, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %32 = load i32, ptr %i, align 4
  %inc = add i32 %32, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %33 = load i32, ptr %x.addr, align 4
  %34 = load i32, ptr %y.addr, align 4
  %xor23 = xor i32 %33, %34
  %and24 = and i32 %xor23, 512
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else32

if.then26:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %y.addr, align 4
  %37 = load i32, ptr %x.addr, align 4
  %or27 = or i32 %36, %37
  %xor28 = xor i32 %35, %or27
  store i32 %xor28, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %x.addr, align 4
  %40 = load i32, ptr %x.addr, align 4
  %add29 = add i32 %39, %40
  %41 = load i32, ptr %acc, align 4
  %or30 = or i32 %add29, %41
  %xor31 = xor i32 %38, %or30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end38

if.else32:                                        ; preds = %for.end
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %acc, align 4
  %44 = load i32, ptr %x.addr, align 4
  %or33 = or i32 %43, %44
  %45 = load i32, ptr %acc, align 4
  %or34 = or i32 1, %45
  %and35 = and i32 %or33, %or34
  %46 = load i32, ptr %x.addr, align 4
  %xor36 = xor i32 %and35, %46
  %xor37 = xor i32 %42, %xor36
  store i32 %xor37, ptr %acc, align 4
  br label %if.end38

if.end38:                                         ; preds = %if.else32, %if.then26
  %47 = load i32, ptr %acc, align 4
  ret i32 %47
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

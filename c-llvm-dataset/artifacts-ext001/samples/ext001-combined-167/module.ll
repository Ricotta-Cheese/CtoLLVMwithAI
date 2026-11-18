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
  %mul = mul i32 %2, %3
  store i32 %mul, ptr %acc, align 4
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
  %shl = shl i32 %8, 2
  %9 = load i32, ptr %y.addr, align 4
  %10 = load i32, ptr %y.addr, align 4
  %add2 = add i32 %9, %10
  %and3 = and i32 %shl, %add2
  %xor = xor i32 %7, %and3
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %12, %13
  %xor4 = xor i32 %11, %sub
  store i32 %xor4, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %xor5 = xor i32 %14, %15
  %16 = load i32, ptr %i, align 4
  %xor6 = xor i32 %xor5, %16
  %and7 = and i32 %xor6, 1
  %cmp8 = icmp eq i32 %and7, 0
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %x.addr, align 4
  %shl9 = shl i32 %18, 23
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %i, align 4
  %and10 = and i32 %19, %20
  %sub11 = sub i32 %shl9, %and10
  %xor12 = xor i32 %17, %sub11
  store i32 %xor12, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %shl13 = shl i32 %22, 11
  %or = or i32 -1, %shl13
  %23 = load i32, ptr %i, align 4
  %xor14 = xor i32 31, %23
  %shl15 = shl i32 %xor14, 15
  %xor16 = xor i32 %or, %shl15
  %xor17 = xor i32 %21, %xor16
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %xor18 = xor i32 %24, %25
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %26 = load i32, ptr %i, align 4
  %inc = add i32 %26, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %27 = load i32, ptr %x.addr, align 4
  %28 = load i32, ptr %y.addr, align 4
  %xor19 = xor i32 %27, %28
  %and20 = and i32 %xor19, 262144
  %cmp21 = icmp eq i32 %and20, 0
  br i1 %cmp21, label %if.then22, label %if.else26

if.then22:                                        ; preds = %for.end
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %x.addr, align 4
  %31 = load i32, ptr %acc, align 4
  %add23 = add i32 %30, %31
  %mul24 = mul i32 0, %add23
  %shr = lshr i32 %mul24, 8
  %xor25 = xor i32 %29, %shr
  store i32 %xor25, ptr %acc, align 4
  br label %if.end32

if.else26:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %xor27 = xor i32 %33, 31
  %xor28 = xor i32 %32, %xor27
  store i32 %xor28, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %sub29 = sub i32 -1, %35
  %shr30 = lshr i32 %sub29, 7
  %xor31 = xor i32 %34, %shr30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.else26, %if.then22
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

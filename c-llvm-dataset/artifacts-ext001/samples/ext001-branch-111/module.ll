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
  store i32 %x, ptr %x.addr, align 4
  store i32 %y, ptr %y.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %y.addr, align 4
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %2, %3
  store i32 %mul, ptr %acc, align 4
  %4 = load i32, ptr %x.addr, align 4
  %5 = load i32, ptr %y.addr, align 4
  %xor = xor i32 %4, %5
  %and = and i32 %xor, 2
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %6 = load i32, ptr %acc, align 4
  %7 = load i32, ptr %y.addr, align 4
  %8 = load i32, ptr %acc, align 4
  %mul1 = mul i32 %7, %8
  %xor2 = xor i32 %mul1, 0
  %9 = load i32, ptr %x.addr, align 4
  %10 = load i32, ptr %x.addr, align 4
  %mul3 = mul i32 %9, %10
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %11, %12
  %xor4 = xor i32 %mul3, %sub
  %xor5 = xor i32 %xor2, %xor4
  %xor6 = xor i32 %6, %xor5
  store i32 %xor6, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %sub7 = sub i32 %14, %15
  %16 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %16, 15
  %and8 = and i32 %sub7, %shl
  %xor9 = xor i32 %13, %and8
  store i32 %xor9, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %xor10 = xor i32 %18, -996717741
  %sub11 = sub i32 162791424, %xor10
  %xor12 = xor i32 %17, %sub11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %y.addr, align 4
  %and13 = and i32 7, %20
  %21 = load i32, ptr %acc, align 4
  %sub14 = sub i32 %and13, %21
  %or = or i32 %sub14, 1
  %xor15 = xor i32 %19, %or
  store i32 %xor15, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  ret i32 %22
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 27, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}

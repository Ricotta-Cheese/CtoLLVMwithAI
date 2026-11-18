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
  %xor = xor i32 %2, %3
  store i32 %xor, ptr %acc, align 4
  %4 = load i32, ptr %acc, align 4
  %5 = load i32, ptr %acc, align 4
  %6 = load i32, ptr %y.addr, align 4
  %or = or i32 %5, %6
  %shr = lshr i32 %or, 18
  %7 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %7, 28
  %8 = load i32, ptr %acc, align 4
  %shl1 = shl i32 %8, 24
  %or2 = or i32 %shl, %shl1
  %or3 = or i32 %shr, %or2
  %xor4 = xor i32 %4, %or3
  store i32 %xor4, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %xor5 = xor i32 %9, %10
  store i32 %xor5, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %x.addr, align 4
  %and = and i32 %12, %13
  %14 = load i32, ptr %y.addr, align 4
  %and6 = and i32 %and, %14
  %shr7 = lshr i32 %and6, 0
  %xor8 = xor i32 %11, %shr7
  store i32 %xor8, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %shr9 = lshr i32 %16, 9
  %17 = load i32, ptr %acc, align 4
  %xor10 = xor i32 %17, 2
  %or11 = or i32 %shr9, %xor10
  %xor12 = xor i32 %15, %or11
  store i32 %xor12, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  ret i32 %18
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 27, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}

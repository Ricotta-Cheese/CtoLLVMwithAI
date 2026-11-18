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
  %4 = load i32, ptr %acc, align 4
  %5 = load i32, ptr %acc, align 4
  %sub = sub i32 1895489962, %5
  %add = add i32 %4, %sub
  store i32 %add, ptr %acc, align 4
  %6 = load i32, ptr %acc, align 4
  %7 = load i32, ptr %y.addr, align 4
  %8 = load i32, ptr %x.addr, align 4
  %add1 = add i32 %7, %8
  %9 = load i32, ptr %acc, align 4
  %sub2 = sub i32 %9, 31
  %mul3 = mul i32 %add1, %sub2
  %10 = load i32, ptr %y.addr, align 4
  %11 = load i32, ptr %x.addr, align 4
  %mul4 = mul i32 %10, %11
  %12 = load i32, ptr %y.addr, align 4
  %13 = load i32, ptr %acc, align 4
  %add5 = add i32 %12, %13
  %sub6 = sub i32 %mul4, %add5
  %sub7 = sub i32 %mul3, %sub6
  %sub8 = sub i32 %6, %sub7
  store i32 %sub8, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %y.addr, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %add9 = add i32 %16, %17
  %mul10 = mul i32 %15, %add9
  %mul11 = mul i32 %14, %mul10
  store i32 %mul11, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %add12 = add i32 3, %19
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %mul13 = mul i32 %20, %21
  %add14 = add i32 %add12, %mul13
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %y.addr, align 4
  %sub15 = sub i32 %22, %23
  %24 = load i32, ptr %x.addr, align 4
  %sub16 = sub i32 %24, 7
  %sub17 = sub i32 %sub15, %sub16
  %sub18 = sub i32 %add14, %sub17
  %add19 = add i32 %18, %sub18
  store i32 %add19, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  ret i32 %25
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 27, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}

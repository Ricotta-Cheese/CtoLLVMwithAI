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
  %sub = sub i32 %2, %3
  store i32 %sub, ptr %acc, align 4
  %4 = load i32, ptr %acc, align 4
  %5 = load i32, ptr %x.addr, align 4
  %6 = load i32, ptr %acc, align 4
  %sub1 = sub i32 %5, %6
  %7 = load i32, ptr %acc, align 4
  %8 = load i32, ptr %acc, align 4
  %sub2 = sub i32 %7, %8
  %sub3 = sub i32 %sub1, %sub2
  %9 = load i32, ptr %y.addr, align 4
  %10 = load i32, ptr %y.addr, align 4
  %add = add i32 %9, %10
  %11 = load i32, ptr %acc, align 4
  %sub4 = sub i32 %add, %11
  %add5 = add i32 %sub3, %sub4
  %mul = mul i32 %4, %add5
  store i32 %mul, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %y.addr, align 4
  %14 = load i32, ptr %x.addr, align 4
  %15 = load i32, ptr %y.addr, align 4
  %add6 = add i32 %14, %15
  %sub7 = sub i32 %13, %add6
  %16 = load i32, ptr %y.addr, align 4
  %mul8 = mul i32 %sub7, %16
  %mul9 = mul i32 %12, %mul8
  store i32 %mul9, ptr %acc, align 4
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %y.addr, align 4
  %add10 = add i32 %17, %18
  store i32 %add10, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %acc, align 4
  %add11 = add i32 %20, %21
  %sub12 = sub i32 %19, %add11
  store i32 %sub12, ptr %acc, align 4
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

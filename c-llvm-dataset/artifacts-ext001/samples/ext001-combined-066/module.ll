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
  %shl = shl i32 %8, 6
  %xor = xor i32 %7, %shl
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %x.addr, align 4
  %10 = load i32, ptr %y.addr, align 4
  %xor2 = xor i32 %9, %10
  %11 = load i32, ptr %i, align 4
  %xor3 = xor i32 %xor2, %11
  %and4 = and i32 %xor3, 4096
  %cmp5 = icmp eq i32 %and4, 0
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %shl6 = shl i32 %13, 24
  %xor7 = xor i32 %12, %shl6
  store i32 %xor7, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %14 = load i32, ptr %acc, align 4
  %xor8 = xor i32 %14, 0
  store i32 %xor8, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %15 = load i32, ptr %i, align 4
  %inc = add i32 %15, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %16, %17
  %and10 = and i32 %xor9, 131072
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then12, label %if.else15

if.then12:                                        ; preds = %for.end
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %y.addr, align 4
  %add13 = add i32 %19, 15
  %xor14 = xor i32 %18, %add13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end19

if.else15:                                        ; preds = %for.end
  %20 = load i32, ptr %acc, align 4
  %xor16 = xor i32 %20, 3
  store i32 %xor16, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %y.addr, align 4
  %add17 = add i32 %22, %23
  %xor18 = xor i32 %21, %add17
  store i32 %xor18, ptr %acc, align 4
  br label %if.end19

if.end19:                                         ; preds = %if.else15, %if.then12
  %24 = load i32, ptr %acc, align 4
  ret i32 %24
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

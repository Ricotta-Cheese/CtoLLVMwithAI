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
  %8 = load i32, ptr %x.addr, align 4
  %9 = load i32, ptr %acc, align 4
  %and2 = and i32 %8, %9
  %xor = xor i32 %7, %and2
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %12
  %and5 = and i32 %xor4, 131072
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %i, align 4
  %sub = sub i32 7, %14
  %shl = shl i32 %sub, 5
  %xor7 = xor i32 %13, %shl
  store i32 %xor7, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %shr = lshr i32 %16, 14
  %shr8 = lshr i32 %shr, 1
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %acc, align 4
  %or = or i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor9 = xor i32 %19, 15
  %xor10 = xor i32 %or, %xor9
  %or11 = or i32 %shr8, %xor10
  %xor12 = xor i32 %15, %or11
  store i32 %xor12, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %add13 = add i32 %21, 3
  %shl14 = shl i32 %add13, 7
  %22 = load i32, ptr %x.addr, align 4
  %xor15 = xor i32 %22, -1
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %i, align 4
  %or16 = or i32 %23, %24
  %and17 = and i32 %xor15, %or16
  %sub18 = sub i32 %shl14, %and17
  %xor19 = xor i32 %20, %sub18
  store i32 %xor19, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %25 = load i32, ptr %i, align 4
  %inc = add i32 %25, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %26 = load i32, ptr %x.addr, align 4
  %27 = load i32, ptr %y.addr, align 4
  %xor20 = xor i32 %26, %27
  %and21 = and i32 %xor20, 512
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else25

if.then23:                                        ; preds = %for.end
  %28 = load i32, ptr %acc, align 4
  %xor24 = xor i32 %28, 3
  store i32 %xor24, ptr %acc, align 4
  br label %if.end33

if.else25:                                        ; preds = %for.end
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %add26 = add i32 %30, -1372496909
  %31 = load i32, ptr %acc, align 4
  %mul27 = mul i32 3, %31
  %or28 = or i32 %add26, %mul27
  %xor29 = xor i32 %29, %or28
  store i32 %xor29, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %34 = load i32, ptr %x.addr, align 4
  %mul30 = mul i32 %33, %34
  %mul31 = mul i32 845511738, %mul30
  %xor32 = xor i32 %32, %mul31
  store i32 %xor32, ptr %acc, align 4
  br label %if.end33

if.end33:                                         ; preds = %if.else25, %if.then23
  %35 = load i32, ptr %acc, align 4
  ret i32 %35
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

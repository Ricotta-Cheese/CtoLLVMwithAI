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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %8, %9
  %shl = shl i32 %sub, 22
  %xor = xor i32 %7, %shl
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %mul2 = mul i32 %11, %12
  %13 = load i32, ptr %x.addr, align 4
  %14 = load i32, ptr %y.addr, align 4
  %or = or i32 %13, %14
  %sub3 = sub i32 %mul2, %or
  %or4 = or i32 16384, %sub3
  %xor5 = xor i32 %10, %or4
  store i32 %xor5, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %y.addr, align 4
  %shl6 = shl i32 %16, 1
  %xor7 = xor i32 %15, %shl6
  store i32 %xor7, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor9 = xor i32 %xor8, %19
  %and10 = and i32 %xor9, 16777216
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %shl12 = shl i32 %21, 25
  %xor13 = xor i32 %20, %shl12
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %i, align 4
  %add14 = add i32 702043760, %23
  %add15 = add i32 %add14, -1703411510
  %24 = load i32, ptr %i, align 4
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %acc, align 4
  %mul16 = mul i32 %25, %26
  %xor17 = xor i32 %24, %mul16
  %mul18 = mul i32 %add15, %xor17
  %xor19 = xor i32 %22, %mul18
  store i32 %xor19, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %27 = load i32, ptr %i, align 4
  %inc = add i32 %27, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %y.addr, align 4
  %xor20 = xor i32 %28, %29
  %and21 = and i32 %xor20, 1073741824
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else27

if.then23:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %and24 = and i32 1, %31
  %shl25 = shl i32 %and24, 26
  %xor26 = xor i32 %30, %shl25
  store i32 %xor26, ptr %acc, align 4
  br label %if.end37

if.else27:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %or28 = or i32 %33, 0
  %xor29 = xor i32 %32, %or28
  store i32 %xor29, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %y.addr, align 4
  %36 = load i32, ptr %x.addr, align 4
  %or30 = or i32 %35, %36
  %37 = load i32, ptr %x.addr, align 4
  %mul31 = mul i32 %37, 31
  %mul32 = mul i32 %or30, %mul31
  %38 = load i32, ptr %y.addr, align 4
  %39 = load i32, ptr %acc, align 4
  %mul33 = mul i32 %38, %39
  %and34 = and i32 -1, %mul33
  %or35 = or i32 %mul32, %and34
  %xor36 = xor i32 %34, %or35
  store i32 %xor36, ptr %acc, align 4
  br label %if.end37

if.end37:                                         ; preds = %if.else27, %if.then23
  %40 = load i32, ptr %acc, align 4
  ret i32 %40
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

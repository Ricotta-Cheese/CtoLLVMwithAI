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
  %add = add i32 %2, %3
  store i32 %add, ptr %acc, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %x.addr, align 4
  %and = and i32 %5, 15
  %6 = load i32, ptr %y.addr, align 4
  %and1 = and i32 %6, 1
  %add2 = add i32 %and, %and1
  %cmp = icmp ult i32 %4, %add2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32, ptr %acc, align 4
  %8 = load i32, ptr %acc, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %or = or i32 %10, 15
  %sub = sub i32 457946975, %or
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %11, %12
  %13 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %13, 18
  %xor3 = xor i32 %mul, %shl
  %sub4 = sub i32 %sub, %xor3
  %xor5 = xor i32 %9, %sub4
  store i32 %xor5, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %shr = lshr i32 %15, 3
  %xor6 = xor i32 %14, %shr
  store i32 %xor6, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %xor8 = xor i32 %xor7, %18
  %and9 = and i32 %xor8, 65536
  %cmp10 = icmp eq i32 %and9, 0
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %add11 = add i32 %20, 1
  %shl12 = shl i32 %add11, 17
  %xor13 = xor i32 %19, %shl12
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %i, align 4
  %sub14 = sub i32 %22, %23
  %xor15 = xor i32 %21, %sub14
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %24 = load i32, ptr %i, align 4
  %inc = add i32 %24, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %25 = load i32, ptr %x.addr, align 4
  %26 = load i32, ptr %y.addr, align 4
  %xor16 = xor i32 %25, %26
  %and17 = and i32 %xor16, 134217728
  %cmp18 = icmp eq i32 %and17, 0
  br i1 %cmp18, label %if.then19, label %if.else22

if.then19:                                        ; preds = %for.end
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %shl20 = shl i32 %28, 29
  %xor21 = xor i32 %27, %shl20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end30

if.else22:                                        ; preds = %for.end
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %shl23 = shl i32 %30, 6
  %xor24 = xor i32 %29, %shl23
  store i32 %xor24, ptr %acc, align 4
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %y.addr, align 4
  %33 = load i32, ptr %y.addr, align 4
  %sub25 = sub i32 %33, 15
  %34 = load i32, ptr %x.addr, align 4
  %sub26 = sub i32 %34, 15
  %mul27 = mul i32 %sub25, %sub26
  %and28 = and i32 %32, %mul27
  %xor29 = xor i32 %31, %and28
  store i32 %xor29, ptr %acc, align 4
  br label %if.end30

if.end30:                                         ; preds = %if.else22, %if.then19
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

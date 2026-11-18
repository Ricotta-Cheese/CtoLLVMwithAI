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
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %x.addr, align 4
  %10 = load i32, ptr %y.addr, align 4
  %xor2 = xor i32 %9, %10
  %11 = load i32, ptr %i, align 4
  %xor3 = xor i32 %xor2, %11
  %and4 = and i32 %xor3, 512
  %cmp5 = icmp eq i32 %and4, 0
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %14 = load i32, ptr %y.addr, align 4
  %shl = shl i32 %14, 3
  %sub = sub i32 %13, %shl
  %xor6 = xor i32 %12, %sub
  store i32 %xor6, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %y.addr, align 4
  %mul7 = mul i32 %16, %17
  %shl8 = shl i32 %mul7, 26
  %xor9 = xor i32 %shl8, -268435456
  %xor10 = xor i32 %15, %xor9
  store i32 %xor10, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %x.addr, align 4
  %or = or i32 %19, %20
  %xor11 = xor i32 %18, %or
  store i32 %xor11, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %y.addr, align 4
  %mul12 = mul i32 15, %22
  %shr = lshr i32 %mul12, 11
  %23 = load i32, ptr %acc, align 4
  %xor13 = xor i32 %23, 3
  %add14 = add i32 %xor13, 1
  %sub15 = sub i32 %shr, %add14
  %xor16 = xor i32 %21, %sub15
  store i32 %xor16, ptr %acc, align 4
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
  %xor17 = xor i32 %25, %26
  %and18 = and i32 %xor17, -2147483648
  %cmp19 = icmp eq i32 %and18, 0
  br i1 %cmp19, label %if.then20, label %if.else26

if.then20:                                        ; preds = %for.end
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %x.addr, align 4
  %xor21 = xor i32 %27, %28
  store i32 %xor21, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %31 = load i32, ptr %y.addr, align 4
  %or22 = or i32 %30, %31
  %xor23 = xor i32 %or22, 1
  %shr24 = lshr i32 %xor23, 16
  %xor25 = xor i32 %29, %shr24
  store i32 %xor25, ptr %acc, align 4
  br label %if.end34

if.else26:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %add27 = add i32 0, %33
  %34 = load i32, ptr %acc, align 4
  %and28 = and i32 16, %34
  %add29 = add i32 %add27, %and28
  %35 = load i32, ptr %y.addr, align 4
  %36 = load i32, ptr %y.addr, align 4
  %37 = load i32, ptr %x.addr, align 4
  %mul30 = mul i32 %36, %37
  %add31 = add i32 %35, %mul30
  %and32 = and i32 %add29, %add31
  %xor33 = xor i32 %32, %and32
  store i32 %xor33, ptr %acc, align 4
  br label %if.end34

if.end34:                                         ; preds = %if.else26, %if.then20
  %38 = load i32, ptr %acc, align 4
  ret i32 %38
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

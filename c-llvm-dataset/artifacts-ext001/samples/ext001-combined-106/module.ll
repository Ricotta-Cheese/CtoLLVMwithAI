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
  %sub = sub i32 %2, %3
  store i32 %sub, ptr %acc, align 4
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
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %x.addr, align 4
  %xor2 = xor i32 %10, %11
  %shr = lshr i32 %xor2, 7
  %shr3 = lshr i32 %shr, 17
  %xor4 = xor i32 %9, %shr3
  store i32 %xor4, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %14 = load i32, ptr %i, align 4
  %sub5 = sub i32 %13, %14
  %15 = load i32, ptr %y.addr, align 4
  %16 = load i32, ptr %i, align 4
  %and6 = and i32 %15, %16
  %or = or i32 %sub5, %and6
  %17 = load i32, ptr %y.addr, align 4
  %18 = load i32, ptr %x.addr, align 4
  %add7 = add i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %acc, align 4
  %sub8 = sub i32 %19, %20
  %sub9 = sub i32 %add7, %sub8
  %add10 = add i32 %or, %sub9
  %xor11 = xor i32 %12, %add10
  store i32 %xor11, ptr %acc, align 4
  %21 = load i32, ptr %x.addr, align 4
  %22 = load i32, ptr %y.addr, align 4
  %xor12 = xor i32 %21, %22
  %23 = load i32, ptr %i, align 4
  %xor13 = xor i32 %xor12, %23
  %and14 = and i32 %xor13, 131072
  %cmp15 = icmp eq i32 %and14, 0
  br i1 %cmp15, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %26 = load i32, ptr %i, align 4
  %sub16 = sub i32 %25, %26
  %xor17 = xor i32 %24, %sub16
  store i32 %xor17, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %y.addr, align 4
  %29 = load i32, ptr %i, align 4
  %xor18 = xor i32 %28, %29
  %30 = load i32, ptr %y.addr, align 4
  %sub19 = sub i32 15, %30
  %and20 = and i32 %xor18, %sub19
  %xor21 = xor i32 %27, %and20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %32, 28
  %shl22 = shl i32 %shl, 4
  %xor23 = xor i32 %31, %shl22
  store i32 %xor23, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %i, align 4
  %shr24 = lshr i32 %34, 21
  %and25 = and i32 %shr24, 0
  %35 = load i32, ptr %x.addr, align 4
  %36 = load i32, ptr %acc, align 4
  %xor26 = xor i32 %35, %36
  %37 = load i32, ptr %y.addr, align 4
  %sub27 = sub i32 %37, 16
  %or28 = or i32 %xor26, %sub27
  %or29 = or i32 %and25, %or28
  %xor30 = xor i32 %33, %or29
  store i32 %xor30, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %38 = load i32, ptr %i, align 4
  %inc = add i32 %38, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %39 = load i32, ptr %x.addr, align 4
  %40 = load i32, ptr %y.addr, align 4
  %xor31 = xor i32 %39, %40
  %and32 = and i32 %xor31, 1048576
  %cmp33 = icmp eq i32 %and32, 0
  br i1 %cmp33, label %if.then34, label %if.else41

if.then34:                                        ; preds = %for.end
  %41 = load i32, ptr %acc, align 4
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %x.addr, align 4
  %shl35 = shl i32 %43, 20
  %add36 = add i32 %42, %shl35
  %xor37 = xor i32 %41, %add36
  store i32 %xor37, ptr %acc, align 4
  %44 = load i32, ptr %acc, align 4
  %45 = load i32, ptr %acc, align 4
  %shr38 = lshr i32 %45, 2
  %add39 = add i32 0, %shr38
  %xor40 = xor i32 %44, %add39
  store i32 %xor40, ptr %acc, align 4
  br label %if.end45

if.else41:                                        ; preds = %for.end
  %46 = load i32, ptr %acc, align 4
  %47 = load i32, ptr %acc, align 4
  %mul = mul i32 16, %47
  %sub42 = sub i32 %mul, 3
  %or43 = or i32 0, %sub42
  %xor44 = xor i32 %46, %or43
  store i32 %xor44, ptr %acc, align 4
  br label %if.end45

if.end45:                                         ; preds = %if.else41, %if.then34
  %48 = load i32, ptr %acc, align 4
  ret i32 %48
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

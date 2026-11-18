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
  %8 = load i32, ptr %y.addr, align 4
  %add2 = add i32 %8, -1
  %9 = load i32, ptr %i, align 4
  %shr = lshr i32 %9, 9
  %and3 = and i32 %add2, %shr
  %xor = xor i32 %7, %and3
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %12, 6
  %or = or i32 %11, %shl
  %xor4 = xor i32 %10, %or
  store i32 %xor4, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %i, align 4
  %add5 = add i32 %16, -1927770078
  %sub6 = sub i32 %15, %add5
  %xor7 = xor i32 %14, %sub6
  %xor8 = xor i32 %13, %xor7
  store i32 %xor8, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor10 = xor i32 %xor9, %19
  %and11 = and i32 %xor10, 16
  %cmp12 = icmp eq i32 %and11, 0
  br i1 %cmp12, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %and13 = and i32 %21, 0
  %22 = load i32, ptr %acc, align 4
  %add14 = add i32 1, %22
  %sub15 = sub i32 %and13, %add14
  %23 = load i32, ptr %y.addr, align 4
  %shl16 = shl i32 %23, 9
  %24 = load i32, ptr %x.addr, align 4
  %25 = load i32, ptr %acc, align 4
  %xor17 = xor i32 %24, %25
  %mul = mul i32 %shl16, %xor17
  %and18 = and i32 %sub15, %mul
  %xor19 = xor i32 %20, %and18
  store i32 %xor19, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %y.addr, align 4
  %28 = load i32, ptr %y.addr, align 4
  %mul20 = mul i32 %27, %28
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %sub21 = sub i32 %29, %30
  %sub22 = sub i32 %mul20, %sub21
  %shl23 = shl i32 %sub22, 11
  %xor24 = xor i32 %26, %shl23
  store i32 %xor24, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %add25 = add i32 %32, -1408213879
  %shl26 = shl i32 %add25, 27
  %shl27 = shl i32 %shl26, 24
  %xor28 = xor i32 %31, %shl27
  store i32 %xor28, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %i, align 4
  %35 = load i32, ptr %acc, align 4
  %or29 = or i32 %34, %35
  %36 = load i32, ptr %y.addr, align 4
  %37 = load i32, ptr %i, align 4
  %sub30 = sub i32 %36, %37
  %add31 = add i32 %or29, %sub30
  %38 = load i32, ptr %i, align 4
  %mul32 = mul i32 3, %38
  %sub33 = sub i32 %add31, %mul32
  %xor34 = xor i32 %33, %sub33
  store i32 %xor34, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %39 = load i32, ptr %i, align 4
  %inc = add i32 %39, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %40 = load i32, ptr %x.addr, align 4
  %41 = load i32, ptr %y.addr, align 4
  %xor35 = xor i32 %40, %41
  %and36 = and i32 %xor35, 4
  %cmp37 = icmp eq i32 %and36, 0
  br i1 %cmp37, label %if.then38, label %if.else43

if.then38:                                        ; preds = %for.end
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %x.addr, align 4
  %44 = load i32, ptr %x.addr, align 4
  %sub39 = sub i32 %43, %44
  %add40 = add i32 %sub39, 0
  %or41 = or i32 -31744, %add40
  %xor42 = xor i32 %42, %or41
  store i32 %xor42, ptr %acc, align 4
  br label %if.end46

if.else43:                                        ; preds = %for.end
  %45 = load i32, ptr %acc, align 4
  %46 = load i32, ptr %y.addr, align 4
  %xor44 = xor i32 %45, %46
  store i32 %xor44, ptr %acc, align 4
  %47 = load i32, ptr %acc, align 4
  %48 = load i32, ptr %acc, align 4
  %xor45 = xor i32 %47, %48
  store i32 %xor45, ptr %acc, align 4
  br label %if.end46

if.end46:                                         ; preds = %if.else43, %if.then38
  %49 = load i32, ptr %acc, align 4
  ret i32 %49
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

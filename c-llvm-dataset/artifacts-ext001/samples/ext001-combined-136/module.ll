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
  %9 = load i32, ptr %y.addr, align 4
  %xor = xor i32 %8, %9
  %10 = load i32, ptr %x.addr, align 4
  %sub = sub i32 -1, %10
  %add3 = add i32 %xor, %sub
  %shl = shl i32 %add3, 18
  %xor4 = xor i32 %7, %shl
  store i32 %xor4, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %add5 = add i32 31, %12
  %xor6 = xor i32 %11, %add5
  store i32 %xor6, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %y.addr, align 4
  %15 = load i32, ptr %i, align 4
  %shr = lshr i32 %15, 2
  %mul = mul i32 %14, %shr
  %xor7 = xor i32 %13, %mul
  store i32 %xor7, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %xor9 = xor i32 %xor8, %18
  %and10 = and i32 %xor9, 65536
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %y.addr, align 4
  %xor12 = xor i32 %19, %20
  store i32 %xor12, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %y.addr, align 4
  %mul13 = mul i32 %22, %23
  %24 = load i32, ptr %x.addr, align 4
  %25 = load i32, ptr %i, align 4
  %or = or i32 %24, %25
  %sub14 = sub i32 %mul13, %or
  %26 = load i32, ptr %y.addr, align 4
  %27 = load i32, ptr %x.addr, align 4
  %or15 = or i32 %26, %27
  %shl16 = shl i32 %or15, 31
  %or17 = or i32 %sub14, %shl16
  %xor18 = xor i32 %21, %or17
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %xor19 = xor i32 %28, %29
  store i32 %xor19, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %30 = load i32, ptr %i, align 4
  %inc = add i32 %30, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %y.addr, align 4
  %xor20 = xor i32 %31, %32
  %and21 = and i32 %xor20, 256
  %cmp22 = icmp eq i32 %and21, 0
  br i1 %cmp22, label %if.then23, label %if.else32

if.then23:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %shr24 = lshr i32 %34, 5
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %sub25 = sub i32 %35, %36
  %xor26 = xor i32 %shr24, %sub25
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %x.addr, align 4
  %mul27 = mul i32 %37, %38
  %39 = load i32, ptr %acc, align 4
  %add28 = add i32 %39, 3
  %and29 = and i32 %mul27, %add28
  %or30 = or i32 %xor26, %and29
  %xor31 = xor i32 %33, %or30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end38

if.else32:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %mul33 = mul i32 %41, 16
  %42 = load i32, ptr %acc, align 4
  %sub34 = sub i32 %42, 2
  %add35 = add i32 %mul33, %sub34
  %xor36 = xor i32 %40, %add35
  store i32 %xor36, ptr %acc, align 4
  %43 = load i32, ptr %acc, align 4
  %44 = load i32, ptr %y.addr, align 4
  %xor37 = xor i32 %43, %44
  store i32 %xor37, ptr %acc, align 4
  br label %if.end38

if.end38:                                         ; preds = %if.else32, %if.then23
  %45 = load i32, ptr %acc, align 4
  ret i32 %45
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

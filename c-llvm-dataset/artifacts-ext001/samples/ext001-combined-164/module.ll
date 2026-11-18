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
  %8 = load i32, ptr %x.addr, align 4
  %add3 = add i32 0, %8
  %9 = load i32, ptr %y.addr, align 4
  %10 = load i32, ptr %acc, align 4
  %mul = mul i32 %9, %10
  %or = or i32 %add3, %mul
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %y.addr, align 4
  %or4 = or i32 %12, %13
  %sub = sub i32 %11, %or4
  %mul5 = mul i32 %or, %sub
  %xor = xor i32 %7, %mul5
  store i32 %xor, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %y.addr, align 4
  %16 = load i32, ptr %acc, align 4
  %mul6 = mul i32 %15, %16
  %xor7 = xor i32 %14, %mul6
  store i32 %xor7, ptr %acc, align 4
  %17 = load i32, ptr %acc, align 4
  %18 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %18, 19
  %19 = load i32, ptr %i, align 4
  %20 = load i32, ptr %i, align 4
  %xor8 = xor i32 %19, %20
  %add9 = add i32 %shl, %xor8
  %xor10 = xor i32 %17, %add9
  store i32 %xor10, ptr %acc, align 4
  %21 = load i32, ptr %x.addr, align 4
  %22 = load i32, ptr %y.addr, align 4
  %xor11 = xor i32 %21, %22
  %23 = load i32, ptr %i, align 4
  %xor12 = xor i32 %xor11, %23
  %and13 = and i32 %xor12, 16
  %cmp14 = icmp eq i32 %and13, 0
  br i1 %cmp14, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %26 = load i32, ptr %x.addr, align 4
  %mul15 = mul i32 %25, %26
  %shr = lshr i32 %mul15, 27
  %add16 = add i32 %shr, 7
  %xor17 = xor i32 %24, %add16
  store i32 %xor17, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %acc, align 4
  %or18 = or i32 %28, %29
  %30 = load i32, ptr %x.addr, align 4
  %31 = load i32, ptr %x.addr, align 4
  %or19 = or i32 %30, %31
  %mul20 = mul i32 %or18, %or19
  %xor21 = xor i32 %27, %mul20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %i, align 4
  %34 = load i32, ptr %acc, align 4
  %mul22 = mul i32 %33, %34
  %xor23 = xor i32 %32, %mul22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %35 = load i32, ptr %i, align 4
  %inc = add i32 %35, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %36 = load i32, ptr %x.addr, align 4
  %37 = load i32, ptr %y.addr, align 4
  %xor24 = xor i32 %36, %37
  %and25 = and i32 %xor24, 33554432
  %cmp26 = icmp eq i32 %and25, 0
  br i1 %cmp26, label %if.then27, label %if.else30

if.then27:                                        ; preds = %for.end
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %y.addr, align 4
  %add28 = add i32 15, %39
  %xor29 = xor i32 %38, %add28
  store i32 %xor29, ptr %acc, align 4
  br label %if.end33

if.else30:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %y.addr, align 4
  %shr31 = lshr i32 %41, 14
  %xor32 = xor i32 %40, %shr31
  store i32 %xor32, ptr %acc, align 4
  br label %if.end33

if.end33:                                         ; preds = %if.else30, %if.then27
  %42 = load i32, ptr %acc, align 4
  ret i32 %42
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

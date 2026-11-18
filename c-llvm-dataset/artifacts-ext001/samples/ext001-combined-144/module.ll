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
  %9 = load i32, ptr %x.addr, align 4
  %and2 = and i32 %8, %9
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %i, align 4
  %or = or i32 %10, %11
  %add3 = add i32 %and2, %or
  %xor = xor i32 %7, %add3
  store i32 %xor, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %sub = sub i32 %13, 0
  %shr = lshr i32 %sub, 27
  %xor4 = xor i32 %12, %shr
  store i32 %xor4, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %y.addr, align 4
  %add5 = add i32 %15, 16
  %16 = load i32, ptr %acc, align 4
  %shr6 = lshr i32 %16, 10
  %add7 = add i32 %add5, %shr6
  %xor8 = xor i32 %14, %add7
  store i32 %xor8, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor10 = xor i32 %xor9, %19
  %and11 = and i32 %xor10, 67108864
  %cmp12 = icmp eq i32 %and11, 0
  br i1 %cmp12, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %x.addr, align 4
  %shr13 = lshr i32 %21, 11
  %xor14 = xor i32 %20, %shr13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %i, align 4
  %and15 = and i32 31, %23
  %xor16 = xor i32 %and15, 34
  %xor17 = xor i32 %22, %xor16
  store i32 %xor17, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %i, align 4
  %xor18 = xor i32 %24, %25
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %26 = load i32, ptr %i, align 4
  %inc = add i32 %26, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %27 = load i32, ptr %x.addr, align 4
  %28 = load i32, ptr %y.addr, align 4
  %xor19 = xor i32 %27, %28
  %and20 = and i32 %xor19, 16777216
  %cmp21 = icmp eq i32 %and20, 0
  br i1 %cmp21, label %if.then22, label %if.else36

if.then22:                                        ; preds = %for.end
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %sub23 = sub i32 15, %30
  %31 = load i32, ptr %x.addr, align 4
  %sub24 = sub i32 %31, 0
  %mul25 = mul i32 %sub23, %sub24
  %32 = load i32, ptr %x.addr, align 4
  %mul26 = mul i32 %32, 0
  %33 = load i32, ptr %y.addr, align 4
  %34 = load i32, ptr %x.addr, align 4
  %sub27 = sub i32 %33, %34
  %sub28 = sub i32 %mul26, %sub27
  %xor29 = xor i32 %mul25, %sub28
  %xor30 = xor i32 %29, %xor29
  store i32 %xor30, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %37 = load i32, ptr %y.addr, align 4
  %38 = load i32, ptr %y.addr, align 4
  %xor31 = xor i32 %37, %38
  %and32 = and i32 %36, %xor31
  %39 = load i32, ptr %y.addr, align 4
  %shr33 = lshr i32 %39, 8
  %xor34 = xor i32 %and32, %shr33
  %xor35 = xor i32 %35, %xor34
  store i32 %xor35, ptr %acc, align 4
  br label %if.end46

if.else36:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %y.addr, align 4
  %42 = load i32, ptr %acc, align 4
  %xor37 = xor i32 %41, %42
  %or38 = or i32 2, %xor37
  %xor39 = xor i32 %40, %or38
  store i32 %xor39, ptr %acc, align 4
  %43 = load i32, ptr %acc, align 4
  %44 = load i32, ptr %acc, align 4
  %45 = load i32, ptr %x.addr, align 4
  %add40 = add i32 %44, %45
  %46 = load i32, ptr %acc, align 4
  %shr41 = lshr i32 %46, 22
  %or42 = or i32 %add40, %shr41
  %47 = load i32, ptr %y.addr, align 4
  %add43 = add i32 %47, -152241100
  %shl = shl i32 %add43, 17
  %and44 = and i32 %or42, %shl
  %xor45 = xor i32 %43, %and44
  store i32 %xor45, ptr %acc, align 4
  br label %if.end46

if.end46:                                         ; preds = %if.else36, %if.then22
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

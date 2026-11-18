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
  %8 = load i32, ptr %i, align 4
  %9 = load i32, ptr %x.addr, align 4
  %or = or i32 %8, %9
  %xor = xor i32 %7, %or
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %y.addr, align 4
  %12 = load i32, ptr %acc, align 4
  %or2 = or i32 %11, %12
  %sub = sub i32 -1, %or2
  %xor3 = xor i32 %10, %sub
  store i32 %xor3, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %y.addr, align 4
  %15 = load i32, ptr %acc, align 4
  %mul4 = mul i32 %14, %15
  %16 = load i32, ptr %acc, align 4
  %xor5 = xor i32 1, %16
  %mul6 = mul i32 %mul4, %xor5
  %xor7 = xor i32 %13, %mul6
  store i32 %xor7, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor9 = xor i32 %xor8, %19
  %and10 = and i32 %xor9, 33554432
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %add12 = add i32 %21, 0
  %xor13 = xor i32 %20, %add12
  store i32 %xor13, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %23, 0
  %shr14 = lshr i32 %shr, 3
  %xor15 = xor i32 %22, %shr14
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %add16 = add i32 %25, %26
  %xor17 = xor i32 %24, %add16
  store i32 %xor17, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %or18 = or i32 %28, -515810058
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %mul19 = mul i32 %29, %30
  %31 = load i32, ptr %i, align 4
  %shl = shl i32 %31, 21
  %or20 = or i32 %mul19, %shl
  %sub21 = sub i32 %or18, %or20
  %xor22 = xor i32 %27, %sub21
  store i32 %xor22, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %32 = load i32, ptr %i, align 4
  %inc = add i32 %32, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %33 = load i32, ptr %x.addr, align 4
  %34 = load i32, ptr %y.addr, align 4
  %xor23 = xor i32 %33, %34
  %and24 = and i32 %xor23, 33554432
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else28

if.then26:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %35, 0
  store i32 %xor27, ptr %acc, align 4
  br label %if.end41

if.else28:                                        ; preds = %for.end
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %y.addr, align 4
  %38 = load i32, ptr %y.addr, align 4
  %xor29 = xor i32 %37, %38
  %39 = load i32, ptr %y.addr, align 4
  %add30 = add i32 16, %39
  %or31 = or i32 %xor29, %add30
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %x.addr, align 4
  %mul32 = mul i32 %40, %41
  %or33 = or i32 524288, %mul32
  %xor34 = xor i32 %or31, %or33
  %xor35 = xor i32 %36, %xor34
  store i32 %xor35, ptr %acc, align 4
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %x.addr, align 4
  %or36 = or i32 7, %43
  %44 = load i32, ptr %y.addr, align 4
  %45 = load i32, ptr %acc, align 4
  %add37 = add i32 %44, %45
  %and38 = and i32 %or36, %add37
  %shl39 = shl i32 %and38, 1
  %xor40 = xor i32 %42, %shl39
  store i32 %xor40, ptr %acc, align 4
  br label %if.end41

if.end41:                                         ; preds = %if.else28, %if.then26
  %46 = load i32, ptr %acc, align 4
  ret i32 %46
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

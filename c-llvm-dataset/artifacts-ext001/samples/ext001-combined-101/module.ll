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
  %9 = load i32, ptr %i, align 4
  %sub2 = sub i32 %8, %9
  %10 = load i32, ptr %y.addr, align 4
  %11 = load i32, ptr %x.addr, align 4
  %and3 = and i32 %10, %11
  %xor = xor i32 %sub2, %and3
  %and4 = and i32 3, %xor
  %xor5 = xor i32 %7, %and4
  store i32 %xor5, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %12, %13
  %14 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %14
  %and8 = and i32 %xor7, 268435456
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %y.addr, align 4
  %shl = shl i32 %16, 14
  %17 = load i32, ptr %y.addr, align 4
  %18 = load i32, ptr %x.addr, align 4
  %19 = load i32, ptr %x.addr, align 4
  %sub10 = sub i32 %18, %19
  %sub11 = sub i32 %17, %sub10
  %sub12 = sub i32 %shl, %sub11
  %xor13 = xor i32 %15, %sub12
  store i32 %xor13, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %21, 7
  %shr14 = lshr i32 %shr, 5
  %xor15 = xor i32 %20, %shr14
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %x.addr, align 4
  %25 = load i32, ptr %x.addr, align 4
  %mul = mul i32 %24, %25
  %26 = load i32, ptr %acc, align 4
  %xor16 = xor i32 %mul, %26
  %sub17 = sub i32 %23, %xor16
  %xor18 = xor i32 %22, %sub17
  store i32 %xor18, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %x.addr, align 4
  %add19 = add i32 %28, 31
  %shl20 = shl i32 %add19, 8
  %xor21 = xor i32 %27, %shl20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %29 = load i32, ptr %i, align 4
  %inc = add i32 %29, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %30 = load i32, ptr %x.addr, align 4
  %31 = load i32, ptr %y.addr, align 4
  %xor22 = xor i32 %30, %31
  %and23 = and i32 %xor22, 64
  %cmp24 = icmp eq i32 %and23, 0
  br i1 %cmp24, label %if.then25, label %if.else27

if.then25:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %xor26 = xor i32 %32, -527772431
  store i32 %xor26, ptr %acc, align 4
  br label %if.end31

if.else27:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %35 = load i32, ptr %acc, align 4
  %xor28 = xor i32 %34, %35
  %sub29 = sub i32 487515775, %xor28
  %xor30 = xor i32 %33, %sub29
  store i32 %xor30, ptr %acc, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.else27, %if.then25
  %36 = load i32, ptr %acc, align 4
  ret i32 %36
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

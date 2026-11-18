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
  %9 = load i32, ptr %acc, align 4
  %shr = lshr i32 %9, 23
  %and3 = and i32 %8, %shr
  %10 = load i32, ptr %i, align 4
  %or = or i32 0, %10
  %11 = load i32, ptr %i, align 4
  %mul = mul i32 %11, 2
  %mul4 = mul i32 %or, %mul
  %xor = xor i32 %and3, %mul4
  %xor5 = xor i32 %7, %xor
  store i32 %xor5, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %14 = load i32, ptr %acc, align 4
  %and6 = and i32 %13, %14
  %mul7 = mul i32 1922685474, %and6
  %15 = load i32, ptr %x.addr, align 4
  %xor8 = xor i32 %15, 3
  %and9 = and i32 %xor8, 0
  %add10 = add i32 %mul7, %and9
  %xor11 = xor i32 %12, %add10
  store i32 %xor11, ptr %acc, align 4
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor12 = xor i32 %16, %17
  %18 = load i32, ptr %i, align 4
  %xor13 = xor i32 %xor12, %18
  %and14 = and i32 %xor13, 16777216
  %cmp15 = icmp eq i32 %and14, 0
  br i1 %cmp15, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %y.addr, align 4
  %sub = sub i32 15, %20
  %xor16 = xor i32 %19, %sub
  store i32 %xor16, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %xor17 = xor i32 %22, 201326592
  %xor18 = xor i32 %21, %xor17
  store i32 %xor18, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %y.addr, align 4
  %25 = load i32, ptr %y.addr, align 4
  %shl = shl i32 %25, 27
  %sub19 = sub i32 %24, %shl
  %xor20 = xor i32 %23, %sub19
  store i32 %xor20, ptr %acc, align 4
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
  %xor21 = xor i32 %27, %28
  %and22 = and i32 %xor21, 32768
  %cmp23 = icmp eq i32 %and22, 0
  br i1 %cmp23, label %if.then24, label %if.else29

if.then24:                                        ; preds = %for.end
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %y.addr, align 4
  %31 = load i32, ptr %acc, align 4
  %sub25 = sub i32 %30, %31
  %shr26 = lshr i32 %sub25, 8
  %xor27 = xor i32 %29, %shr26
  store i32 %xor27, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %xor28 = xor i32 %32, %33
  store i32 %xor28, ptr %acc, align 4
  br label %if.end36

if.else29:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %add30 = add i32 %35, 7
  %36 = load i32, ptr %x.addr, align 4
  %37 = load i32, ptr %x.addr, align 4
  %sub31 = sub i32 %36, %37
  %and32 = and i32 %add30, %sub31
  %xor33 = xor i32 %34, %and32
  store i32 %xor33, ptr %acc, align 4
  %38 = load i32, ptr %acc, align 4
  %39 = load i32, ptr %y.addr, align 4
  %shl34 = shl i32 %39, 20
  %xor35 = xor i32 %38, %shl34
  store i32 %xor35, ptr %acc, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.else29, %if.then24
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

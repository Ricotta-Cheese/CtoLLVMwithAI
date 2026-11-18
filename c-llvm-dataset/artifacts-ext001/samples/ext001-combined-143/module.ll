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
  %mul2 = mul i32 15, %8
  %9 = load i32, ptr %acc, align 4
  %xor = xor i32 %9, -1
  %mul3 = mul i32 %mul2, %xor
  %xor4 = xor i32 %7, %mul3
  store i32 %xor4, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %shl = shl i32 %11, 8
  %shl5 = shl i32 %shl, 5
  %12 = load i32, ptr %i, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %x.addr, align 4
  %and6 = and i32 %13, %14
  %sub = sub i32 %12, %and6
  %or = or i32 %shl5, %sub
  %xor7 = xor i32 %10, %or
  store i32 %xor7, ptr %acc, align 4
  %15 = load i32, ptr %x.addr, align 4
  %16 = load i32, ptr %y.addr, align 4
  %xor8 = xor i32 %15, %16
  %17 = load i32, ptr %i, align 4
  %xor9 = xor i32 %xor8, %17
  %and10 = and i32 %xor9, 512
  %cmp11 = icmp eq i32 %and10, 0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %xor12 = xor i32 %18, 31
  store i32 %xor12, ptr %acc, align 4
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %xor13 = xor i32 %20, %21
  %22 = load i32, ptr %i, align 4
  %shl14 = shl i32 %22, 25
  %xor15 = xor i32 %xor13, %shl14
  %23 = load i32, ptr %y.addr, align 4
  %24 = load i32, ptr %x.addr, align 4
  %add16 = add i32 %23, %24
  %25 = load i32, ptr %i, align 4
  %or17 = or i32 0, %25
  %add18 = add i32 %add16, %or17
  %sub19 = sub i32 %xor15, %add18
  %xor20 = xor i32 %19, %sub19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %sub21 = sub i32 %27, %28
  %29 = load i32, ptr %i, align 4
  %sub22 = sub i32 %29, 7
  %xor23 = xor i32 %sub21, %sub22
  %xor24 = xor i32 %26, %xor23
  store i32 %xor24, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %acc, align 4
  %sub25 = sub i32 %31, -1
  %xor26 = xor i32 %30, %sub25
  store i32 %xor26, ptr %acc, align 4
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
  %xor27 = xor i32 %33, %34
  %and28 = and i32 %xor27, 134217728
  %cmp29 = icmp eq i32 %and28, 0
  br i1 %cmp29, label %if.then30, label %if.else34

if.then30:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %xor31 = xor i32 %35, 31
  store i32 %xor31, ptr %acc, align 4
  %36 = load i32, ptr %acc, align 4
  %37 = load i32, ptr %y.addr, align 4
  %38 = load i32, ptr %x.addr, align 4
  %and32 = and i32 %37, %38
  %xor33 = xor i32 %36, %and32
  store i32 %xor33, ptr %acc, align 4
  br label %if.end36

if.else34:                                        ; preds = %for.end
  %39 = load i32, ptr %acc, align 4
  %xor35 = xor i32 %39, 15
  store i32 %xor35, ptr %acc, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.else34, %if.then30
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

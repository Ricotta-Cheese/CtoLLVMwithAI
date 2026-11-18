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
  %9 = load i32, ptr %y.addr, align 4
  %or = or i32 %8, %9
  %xor = xor i32 %7, %or
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %mul = mul i32 1, %11
  %12 = load i32, ptr %y.addr, align 4
  %or2 = or i32 787629723, %12
  %or3 = or i32 %mul, %or2
  %or4 = or i32 %or3, 0
  %xor5 = xor i32 %10, %or4
  store i32 %xor5, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %shl = shl i32 %14, 13
  %15 = load i32, ptr %y.addr, align 4
  %and6 = and i32 %shl, %15
  %16 = load i32, ptr %x.addr, align 4
  %and7 = and i32 %16, 1
  %17 = load i32, ptr %y.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %and8 = and i32 %17, %18
  %and9 = and i32 %and7, %and8
  %and10 = and i32 %and6, %and9
  %xor11 = xor i32 %13, %and10
  store i32 %xor11, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %y.addr, align 4
  %xor12 = xor i32 %19, %20
  %21 = load i32, ptr %i, align 4
  %xor13 = xor i32 %xor12, %21
  %and14 = and i32 %xor13, 524288
  %cmp15 = icmp eq i32 %and14, 0
  br i1 %cmp15, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %i, align 4
  %xor16 = xor i32 15, %23
  %xor17 = xor i32 %xor16, 0
  %xor18 = xor i32 %22, %xor17
  store i32 %xor18, ptr %acc, align 4
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %y.addr, align 4
  %26 = load i32, ptr %x.addr, align 4
  %or19 = or i32 %25, %26
  %xor20 = xor i32 %24, %or19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %y.addr, align 4
  %xor21 = xor i32 31, %28
  %xor22 = xor i32 %27, %xor21
  store i32 %xor22, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %y.addr, align 4
  %and23 = and i32 %30, %31
  %mul24 = mul i32 0, %and23
  %xor25 = xor i32 %29, %mul24
  store i32 %xor25, ptr %acc, align 4
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
  %xor26 = xor i32 %33, %34
  %and27 = and i32 %xor26, 4096
  %cmp28 = icmp eq i32 %and27, 0
  br i1 %cmp28, label %if.then29, label %if.else31

if.then29:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %y.addr, align 4
  %xor30 = xor i32 %35, %36
  store i32 %xor30, ptr %acc, align 4
  br label %if.end33

if.else31:                                        ; preds = %for.end
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %x.addr, align 4
  %xor32 = xor i32 %37, %38
  store i32 %xor32, ptr %acc, align 4
  br label %if.end33

if.end33:                                         ; preds = %if.else31, %if.then29
  %39 = load i32, ptr %acc, align 4
  ret i32 %39
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

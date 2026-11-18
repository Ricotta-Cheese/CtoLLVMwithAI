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
  %and2 = and i32 %8, 0
  %9 = load i32, ptr %i, align 4
  %10 = load i32, ptr %acc, align 4
  %add3 = add i32 %9, %10
  %and4 = and i32 %and2, %add3
  %xor = xor i32 %7, %and4
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %xor5 = xor i32 %11, 2009900945
  store i32 %xor5, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %14 = load i32, ptr %x.addr, align 4
  %mul6 = mul i32 %13, %14
  %mul7 = mul i32 -199033833, %mul6
  %xor8 = xor i32 %12, %mul7
  store i32 %xor8, ptr %acc, align 4
  %15 = load i32, ptr %x.addr, align 4
  %16 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 %15, %16
  %17 = load i32, ptr %i, align 4
  %xor10 = xor i32 %xor9, %17
  %and11 = and i32 %xor10, 1048576
  %cmp12 = icmp eq i32 %and11, 0
  br i1 %cmp12, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %shl = shl i32 %19, 4
  %sub = sub i32 %shl, -1
  %xor13 = xor i32 %18, %sub
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %shr = lshr i32 %21, 10
  %xor14 = xor i32 %20, %shr
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %22 = load i32, ptr %i, align 4
  %inc = add i32 %22, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %23 = load i32, ptr %x.addr, align 4
  %24 = load i32, ptr %y.addr, align 4
  %xor15 = xor i32 %23, %24
  %and16 = and i32 %xor15, 131072
  %cmp17 = icmp eq i32 %and16, 0
  br i1 %cmp17, label %if.then18, label %if.else21

if.then18:                                        ; preds = %for.end
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %x.addr, align 4
  %and19 = and i32 %26, 1
  %xor20 = xor i32 %25, %and19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end26

if.else21:                                        ; preds = %for.end
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %xor22 = xor i32 %27, %28
  store i32 %xor22, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %x.addr, align 4
  %31 = load i32, ptr %x.addr, align 4
  %xor23 = xor i32 %30, %31
  %shl24 = shl i32 %xor23, 25
  %xor25 = xor i32 %29, %shl24
  store i32 %xor25, ptr %acc, align 4
  br label %if.end26

if.end26:                                         ; preds = %if.else21, %if.then18
  %32 = load i32, ptr %acc, align 4
  ret i32 %32
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

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
  %12 = load i32, ptr %i, align 4
  %add2 = add i32 %11, %12
  %13 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %add2, %13
  %xor3 = xor i32 %10, %sub
  store i32 %xor3, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %16 = load i32, ptr %acc, align 4
  %mul4 = mul i32 %15, %16
  %shr = lshr i32 %mul4, 0
  %xor5 = xor i32 %14, %shr
  store i32 %xor5, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %19
  %and8 = and i32 %xor7, 512
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %i, align 4
  %22 = load i32, ptr %x.addr, align 4
  %sub10 = sub i32 %21, %22
  %23 = load i32, ptr %i, align 4
  %24 = load i32, ptr %acc, align 4
  %add11 = add i32 %23, %24
  %add12 = add i32 %sub10, %add11
  %sub13 = sub i32 %add12, -1
  %xor14 = xor i32 %20, %sub13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %x.addr, align 4
  %xor15 = xor i32 %25, %26
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %27 = load i32, ptr %i, align 4
  %inc = add i32 %27, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %28 = load i32, ptr %x.addr, align 4
  %29 = load i32, ptr %y.addr, align 4
  %xor16 = xor i32 %28, %29
  %and17 = and i32 %xor16, 134217728
  %cmp18 = icmp eq i32 %and17, 0
  br i1 %cmp18, label %if.then19, label %if.else22

if.then19:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %y.addr, align 4
  %32 = load i32, ptr %x.addr, align 4
  %mul20 = mul i32 %31, %32
  %xor21 = xor i32 %30, %mul20
  store i32 %xor21, ptr %acc, align 4
  br label %if.end27

if.else22:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %35 = load i32, ptr %y.addr, align 4
  %add23 = add i32 %34, %35
  %36 = load i32, ptr %x.addr, align 4
  %37 = load i32, ptr %x.addr, align 4
  %mul24 = mul i32 %36, %37
  %and25 = and i32 %add23, %mul24
  %xor26 = xor i32 %33, %and25
  store i32 %xor26, ptr %acc, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.else22, %if.then19
  %38 = load i32, ptr %acc, align 4
  ret i32 %38
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

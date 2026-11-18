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
  %8 = load i32, ptr %y.addr, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %x.addr, align 4
  %10 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %9, %10
  %11 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %11
  %and5 = and i32 %xor4, 256
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %i, align 4
  %14 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %13, %14
  %15 = load i32, ptr %y.addr, align 4
  %xor7 = xor i32 %15, 1
  %and8 = and i32 %mul, %xor7
  %16 = load i32, ptr %acc, align 4
  %shl = shl i32 %16, 21
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %i, align 4
  %sub = sub i32 %17, %18
  %and9 = and i32 %shl, %sub
  %mul10 = mul i32 %and8, %and9
  %xor11 = xor i32 %12, %mul10
  store i32 %xor11, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %19 = load i32, ptr %acc, align 4
  %20 = load i32, ptr %i, align 4
  %21 = load i32, ptr %x.addr, align 4
  %mul12 = mul i32 %20, %21
  %xor13 = xor i32 %19, %mul12
  store i32 %xor13, ptr %acc, align 4
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
  %xor14 = xor i32 %23, %24
  %and15 = and i32 %xor14, 128
  %cmp16 = icmp eq i32 %and15, 0
  br i1 %cmp16, label %if.then17, label %if.else24

if.then17:                                        ; preds = %for.end
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %x.addr, align 4
  %mul18 = mul i32 %26, %27
  %28 = load i32, ptr %y.addr, align 4
  %sub19 = sub i32 %28, 2
  %sub20 = sub i32 %mul18, %sub19
  %xor21 = xor i32 %25, %sub20
  store i32 %xor21, ptr %acc, align 4
  %29 = load i32, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %y.addr, align 4
  %xor22 = xor i32 %30, %31
  %xor23 = xor i32 %29, %xor22
  store i32 %xor23, ptr %acc, align 4
  br label %if.end29

if.else24:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %add25 = add i32 -1, %33
  %and26 = and i32 -16384, %add25
  %xor27 = xor i32 %32, %and26
  store i32 %xor27, ptr %acc, align 4
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %35, 6
  %xor28 = xor i32 %34, %shr
  store i32 %xor28, ptr %acc, align 4
  br label %if.end29

if.end29:                                         ; preds = %if.else24, %if.then17
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

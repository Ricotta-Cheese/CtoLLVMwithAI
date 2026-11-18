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
  %8 = load i32, ptr %acc, align 4
  %9 = load i32, ptr %y.addr, align 4
  %mul = mul i32 %8, %9
  %10 = load i32, ptr %y.addr, align 4
  %11 = load i32, ptr %x.addr, align 4
  %and2 = and i32 %10, %11
  %or = or i32 0, %and2
  %sub3 = sub i32 %mul, %or
  %xor = xor i32 %7, %sub3
  store i32 %xor, ptr %acc, align 4
  %12 = load i32, ptr %acc, align 4
  %13 = load i32, ptr %acc, align 4
  %shl = shl i32 %13, 27
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %i, align 4
  %or4 = or i32 %14, %15
  %sub5 = sub i32 %shl, %or4
  %xor6 = xor i32 7, %sub5
  %xor7 = xor i32 %12, %xor6
  store i32 %xor7, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %sub8 = sub i32 -1724588403, %17
  %18 = load i32, ptr %x.addr, align 4
  %19 = load i32, ptr %acc, align 4
  %and9 = and i32 %18, %19
  %sub10 = sub i32 %sub8, %and9
  %and11 = and i32 %sub10, 7
  %xor12 = xor i32 %16, %and11
  store i32 %xor12, ptr %acc, align 4
  %20 = load i32, ptr %x.addr, align 4
  %21 = load i32, ptr %y.addr, align 4
  %xor13 = xor i32 %20, %21
  %22 = load i32, ptr %i, align 4
  %xor14 = xor i32 %xor13, %22
  %and15 = and i32 %xor14, 536870912
  %cmp16 = icmp eq i32 %and15, 0
  br i1 %cmp16, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %23 = load i32, ptr %acc, align 4
  %24 = load i32, ptr %y.addr, align 4
  %xor17 = xor i32 %23, %24
  store i32 %xor17, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %mul18 = mul i32 1, %26
  %27 = load i32, ptr %i, align 4
  %28 = load i32, ptr %y.addr, align 4
  %sub19 = sub i32 %27, %28
  %sub20 = sub i32 2, %sub19
  %sub21 = sub i32 %mul18, %sub20
  %xor22 = xor i32 %25, %sub21
  store i32 %xor22, ptr %acc, align 4
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
  %xor23 = xor i32 %30, %31
  %and24 = and i32 %xor23, 4
  %cmp25 = icmp eq i32 %and24, 0
  br i1 %cmp25, label %if.then26, label %if.else28

if.then26:                                        ; preds = %for.end
  %32 = load i32, ptr %acc, align 4
  %xor27 = xor i32 %32, 0
  store i32 %xor27, ptr %acc, align 4
  br label %if.end32

if.else28:                                        ; preds = %for.end
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %34, 2
  %xor29 = xor i32 %33, %shr
  store i32 %xor29, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %acc, align 4
  %sub30 = sub i32 31, %36
  %xor31 = xor i32 %35, %sub30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.else28, %if.then26
  %37 = load i32, ptr %acc, align 4
  ret i32 %37
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

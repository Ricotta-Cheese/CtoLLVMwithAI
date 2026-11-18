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
  %shr = lshr i32 %8, 13
  %9 = load i32, ptr %i, align 4
  %mul = mul i32 %shr, %9
  %shl = shl i32 %mul, 8
  %xor = xor i32 %7, %shl
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %x.addr, align 4
  %11 = load i32, ptr %y.addr, align 4
  %xor3 = xor i32 %10, %11
  %12 = load i32, ptr %i, align 4
  %xor4 = xor i32 %xor3, %12
  %and5 = and i32 %xor4, 8192
  %cmp6 = icmp eq i32 %and5, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %13 = load i32, ptr %acc, align 4
  %14 = load i32, ptr %acc, align 4
  %15 = load i32, ptr %i, align 4
  %add7 = add i32 %14, %15
  %16 = load i32, ptr %x.addr, align 4
  %17 = load i32, ptr %i, align 4
  %and8 = and i32 %16, %17
  %add9 = add i32 %add7, %and8
  %18 = load i32, ptr %x.addr, align 4
  %shr10 = lshr i32 %18, 4
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %i, align 4
  %and11 = and i32 %19, %20
  %add12 = add i32 %shr10, %and11
  %and13 = and i32 %add9, %add12
  %xor14 = xor i32 %13, %and13
  store i32 %xor14, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %21 = load i32, ptr %acc, align 4
  %22 = load i32, ptr %acc, align 4
  %mul15 = mul i32 %22, 2
  %23 = load i32, ptr %x.addr, align 4
  %and16 = and i32 %23, 16
  %or = or i32 %mul15, %and16
  %24 = load i32, ptr %x.addr, align 4
  %mul17 = mul i32 -2, %24
  %add18 = add i32 %or, %mul17
  %xor19 = xor i32 %21, %add18
  store i32 %xor19, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %shr20 = lshr i32 %26, 17
  %xor21 = xor i32 %25, %shr20
  store i32 %xor21, ptr %acc, align 4
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
  %xor22 = xor i32 %28, %29
  %and23 = and i32 %xor22, 65536
  %cmp24 = icmp eq i32 %and23, 0
  br i1 %cmp24, label %if.then25, label %if.else29

if.then25:                                        ; preds = %for.end
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %xor26 = xor i32 %30, %31
  store i32 %xor26, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %xor27 = xor i32 0, %33
  %xor28 = xor i32 %32, %xor27
  store i32 %xor28, ptr %acc, align 4
  br label %if.end38

if.else29:                                        ; preds = %for.end
  %34 = load i32, ptr %acc, align 4
  %35 = load i32, ptr %acc, align 4
  %add30 = add i32 7, %35
  %36 = load i32, ptr %x.addr, align 4
  %and31 = and i32 %36, 15
  %add32 = add i32 %add30, %and31
  %xor33 = xor i32 %34, %add32
  store i32 %xor33, ptr %acc, align 4
  %37 = load i32, ptr %acc, align 4
  %38 = load i32, ptr %x.addr, align 4
  %39 = load i32, ptr %x.addr, align 4
  %40 = load i32, ptr %acc, align 4
  %and34 = and i32 %39, %40
  %and35 = and i32 %38, %and34
  %xor36 = xor i32 -291418751, %and35
  %xor37 = xor i32 %37, %xor36
  store i32 %xor37, ptr %acc, align 4
  br label %if.end38

if.end38:                                         ; preds = %if.else29, %if.then25
  %41 = load i32, ptr %acc, align 4
  ret i32 %41
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

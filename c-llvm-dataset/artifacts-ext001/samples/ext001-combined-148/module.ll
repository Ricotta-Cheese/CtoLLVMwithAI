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
  %sub2 = sub i32 %8, %9
  %mul = mul i32 %sub2, 262143
  %shl = shl i32 %mul, 20
  %xor = xor i32 %7, %shl
  store i32 %xor, ptr %acc, align 4
  %10 = load i32, ptr %acc, align 4
  %11 = load i32, ptr %x.addr, align 4
  %12 = load i32, ptr %acc, align 4
  %add3 = add i32 %11, %12
  %13 = load i32, ptr %acc, align 4
  %shl4 = shl i32 %13, 6
  %mul5 = mul i32 %add3, %shl4
  %14 = load i32, ptr %x.addr, align 4
  %shr = lshr i32 %14, 29
  %or = or i32 -1, %shr
  %xor6 = xor i32 %mul5, %or
  %xor7 = xor i32 %10, %xor6
  store i32 %xor7, ptr %acc, align 4
  %15 = load i32, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %y.addr, align 4
  %mul8 = mul i32 %16, %17
  %18 = load i32, ptr %y.addr, align 4
  %xor9 = xor i32 2, %18
  %and10 = and i32 %mul8, %xor9
  %shl11 = shl i32 %and10, 26
  %xor12 = xor i32 %15, %shl11
  store i32 %xor12, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %20 = load i32, ptr %y.addr, align 4
  %xor13 = xor i32 %19, %20
  %21 = load i32, ptr %i, align 4
  %xor14 = xor i32 %xor13, %21
  %and15 = and i32 %xor14, 16384
  %cmp16 = icmp eq i32 %and15, 0
  br i1 %cmp16, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %i, align 4
  %add17 = add i32 %23, 2
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %y.addr, align 4
  %mul18 = mul i32 %24, %25
  %and19 = and i32 %add17, %mul18
  %xor20 = xor i32 %22, %and19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %i, align 4
  %28 = load i32, ptr %y.addr, align 4
  %add21 = add i32 %27, %28
  %29 = load i32, ptr %acc, align 4
  %xor22 = xor i32 472310085, %29
  %xor23 = xor i32 %add21, %xor22
  %xor24 = xor i32 %26, %xor23
  store i32 %xor24, ptr %acc, align 4
  %30 = load i32, ptr %acc, align 4
  %31 = load i32, ptr %x.addr, align 4
  %32 = load i32, ptr %y.addr, align 4
  %sub25 = sub i32 %31, %32
  %33 = load i32, ptr %x.addr, align 4
  %34 = load i32, ptr %x.addr, align 4
  %mul26 = mul i32 %33, %34
  %mul27 = mul i32 %sub25, %mul26
  %35 = load i32, ptr %x.addr, align 4
  %shl28 = shl i32 %35, 22
  %36 = load i32, ptr %y.addr, align 4
  %or29 = or i32 %shl28, %36
  %xor30 = xor i32 %mul27, %or29
  %xor31 = xor i32 %30, %xor30
  store i32 %xor31, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %37 = load i32, ptr %i, align 4
  %inc = add i32 %37, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %38 = load i32, ptr %x.addr, align 4
  %39 = load i32, ptr %y.addr, align 4
  %xor32 = xor i32 %38, %39
  %and33 = and i32 %xor32, 134217728
  %cmp34 = icmp eq i32 %and33, 0
  br i1 %cmp34, label %if.then35, label %if.else38

if.then35:                                        ; preds = %for.end
  %40 = load i32, ptr %acc, align 4
  %41 = load i32, ptr %acc, align 4
  %shl36 = shl i32 %41, 25
  %xor37 = xor i32 %40, %shl36
  store i32 %xor37, ptr %acc, align 4
  br label %if.end42

if.else38:                                        ; preds = %for.end
  %42 = load i32, ptr %acc, align 4
  %43 = load i32, ptr %acc, align 4
  %xor39 = xor i32 %42, %43
  store i32 %xor39, ptr %acc, align 4
  %44 = load i32, ptr %acc, align 4
  %45 = load i32, ptr %acc, align 4
  %46 = load i32, ptr %y.addr, align 4
  %xor40 = xor i32 %45, %46
  %xor41 = xor i32 %44, %xor40
  store i32 %xor41, ptr %acc, align 4
  br label %if.end42

if.end42:                                         ; preds = %if.else38, %if.then35
  %47 = load i32, ptr %acc, align 4
  ret i32 %47
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

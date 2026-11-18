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
  %8 = load i32, ptr %acc, align 4
  %xor = xor i32 %7, %8
  store i32 %xor, ptr %acc, align 4
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %y.addr, align 4
  %shl = shl i32 %10, 3
  %11 = load i32, ptr %i, align 4
  %12 = load i32, ptr %x.addr, align 4
  %add3 = add i32 %11, %12
  %add4 = add i32 %shl, %add3
  %xor5 = xor i32 %9, %add4
  store i32 %xor5, ptr %acc, align 4
  %13 = load i32, ptr %x.addr, align 4
  %14 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %13, %14
  %15 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %15
  %and8 = and i32 %xor7, 16384
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %17, 23
  %xor10 = xor i32 %16, %shr
  store i32 %xor10, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %x.addr, align 4
  %xor11 = xor i32 31, %19
  %xor12 = xor i32 %18, %xor11
  store i32 %xor12, ptr %acc, align 4
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %x.addr, align 4
  %xor13 = xor i32 %20, %21
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
  br i1 %cmp16, label %if.then17, label %if.else21

if.then17:                                        ; preds = %for.end
  %25 = load i32, ptr %acc, align 4
  %xor18 = xor i32 %25, 1
  store i32 %xor18, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %y.addr, align 4
  %and19 = and i32 -1, %27
  %xor20 = xor i32 %26, %and19
  store i32 %xor20, ptr %acc, align 4
  br label %if.end25

if.else21:                                        ; preds = %for.end
  %28 = load i32, ptr %acc, align 4
  %29 = load i32, ptr %x.addr, align 4
  %30 = load i32, ptr %x.addr, align 4
  %sub = sub i32 %29, %30
  %xor22 = xor i32 %28, %sub
  store i32 %xor22, ptr %acc, align 4
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %y.addr, align 4
  %33 = load i32, ptr %y.addr, align 4
  %add23 = add i32 %32, %33
  %or = or i32 %add23, -1
  %xor24 = xor i32 %31, %or
  store i32 %xor24, ptr %acc, align 4
  br label %if.end25

if.end25:                                         ; preds = %if.else21, %if.then17
  %34 = load i32, ptr %acc, align 4
  ret i32 %34
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

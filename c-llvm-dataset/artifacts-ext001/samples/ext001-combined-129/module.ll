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
  %8 = load i32, ptr %y.addr, align 4
  %9 = load i32, ptr %y.addr, align 4
  %and2 = and i32 %8, %9
  %10 = load i32, ptr %y.addr, align 4
  %xor = xor i32 7, %10
  %and3 = and i32 %and2, %xor
  %or = or i32 %and3, 272286416
  %xor4 = xor i32 %7, %or
  store i32 %xor4, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %xor5 = xor i32 %11, 0
  store i32 %xor5, ptr %acc, align 4
  %12 = load i32, ptr %x.addr, align 4
  %13 = load i32, ptr %y.addr, align 4
  %xor6 = xor i32 %12, %13
  %14 = load i32, ptr %i, align 4
  %xor7 = xor i32 %xor6, %14
  %and8 = and i32 %xor7, 67108864
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32, ptr %acc, align 4
  %xor10 = xor i32 %15, 7
  store i32 %xor10, ptr %acc, align 4
  %16 = load i32, ptr %acc, align 4
  %17 = load i32, ptr %y.addr, align 4
  %xor11 = xor i32 %16, %17
  store i32 %xor11, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %18 = load i32, ptr %acc, align 4
  %19 = load i32, ptr %y.addr, align 4
  %20 = load i32, ptr %i, align 4
  %or12 = or i32 %19, %20
  %xor13 = xor i32 %18, %or12
  store i32 %xor13, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %21 = load i32, ptr %i, align 4
  %inc = add i32 %21, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %22 = load i32, ptr %x.addr, align 4
  %23 = load i32, ptr %y.addr, align 4
  %xor14 = xor i32 %22, %23
  %and15 = and i32 %xor14, 32
  %cmp16 = icmp eq i32 %and15, 0
  br i1 %cmp16, label %if.then17, label %if.else20

if.then17:                                        ; preds = %for.end
  %24 = load i32, ptr %acc, align 4
  %25 = load i32, ptr %y.addr, align 4
  %26 = load i32, ptr %y.addr, align 4
  %xor18 = xor i32 %25, %26
  %xor19 = xor i32 %24, %xor18
  store i32 %xor19, ptr %acc, align 4
  br label %if.end28

if.else20:                                        ; preds = %for.end
  %27 = load i32, ptr %acc, align 4
  %28 = load i32, ptr %acc, align 4
  %add21 = add i32 7, %28
  %29 = load i32, ptr %y.addr, align 4
  %xor22 = xor i32 %add21, %29
  %30 = load i32, ptr %y.addr, align 4
  %31 = load i32, ptr %acc, align 4
  %xor23 = xor i32 %30, %31
  %mul24 = mul i32 -1, %xor23
  %add25 = add i32 %xor22, %mul24
  %xor26 = xor i32 %27, %add25
  store i32 %xor26, ptr %acc, align 4
  %32 = load i32, ptr %acc, align 4
  %33 = load i32, ptr %y.addr, align 4
  %shl = shl i32 %33, 3
  %xor27 = xor i32 %32, %shl
  store i32 %xor27, ptr %acc, align 4
  br label %if.end28

if.end28:                                         ; preds = %if.else20, %if.then17
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

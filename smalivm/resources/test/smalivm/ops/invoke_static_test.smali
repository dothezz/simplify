.class Linvoke_static_test;
.super Ljava/lang/Object;

.field public static mutable:[I
.field public static not_initialized:Ljava/lang/String;
.field public static sometimes_initialized:Ljava/lang/String;

.method public static invokeReturnVoid()V
    .locals 0

    invoke-static {}, Linvoke_static_test;->returnVoid()V

    return-void
.end method

.method public static invokeReturnInt()V
    .locals 0

    invoke-static {}, Linvoke_static_test;->returnInt()I

    return-void
.end method

.method public static invokeReturnParameter()V
    .locals 1

    invoke-static {v0}, Linvoke_static_test;->returnParameter(I)I

    return-void
.end method

.method public static invokeMutateString()V
    .locals 1

    invoke-static {v0}, Linvoke_static_test;->mutateString(Ljava/lang/String;)V

    return-void
.end method

.method public static invokeMutateStringBuilder()V
    .locals 1

    invoke-static {v0}, Linvoke_static_test;->mutateStringBuilder(Ljava/lang/StringBuilder;)V

    return-void
.end method

.method public static invokeNonExistantMethodWithTwoArrayParameters()V
    .locals 1

    invoke-static {v0, v1}, Lim_not_your_friend_buddy;->Im_not_your_buddy_guy([I[I)V

    return-void
.end method


.method public static invokeSet0thElementOfFirstParameterTo0IfSecondParameterIs0()V
    .locals 1

    invoke-static {v0, v1}, Linvoke_static_test;->set0thElementOfFirstParameterTo0IfSecondParameterIs0([II)V

    return-void
.end method

.method public invokeMutateStaticClassField()V
    .locals 1

    invoke-static {}, Linvoke_static_test;->mutateStaticClassField()V

    return-void
.end method

.method public invokeMutateStaticClassFieldNonDeterministically()V
    .locals 1

    invoke-static {}, Linvoke_static_test;->mutateStaticClassFieldNonDeterministically()V

    return-void
.end method

# Need proper error handling, and to test private and instance from static
#.method public static TestPrivateMethodInaccessible()V
#.end method

#.method public static TestUnknownMethodMutableAndImmutableParametersMutateOnlyMutableAndReturnUnknownValue()V
#.end method

.method public static nonDeterministicallyInitializeClassWithStaticInit()V
    .locals 1

    sget v0, Lsome_unexistant_class;->fieldy:I
    if-eqz v0, :was_zero

    invoke-static {}, Lclass_with_static_init;->getString()Ljava/lang/String;
    move-result v0

    :was_zero
    return-void
.end method

.method public static mutateStaticClassField()V
    .locals 2

    sget-object v0, Linvoke_static_test;->mutable:[I

    const/4 v1, 0x0
    aput v1, v0, v1

    return-void
.end method

.method public static invokeReturnUninitializedField()V
    .locals 0

    invoke-static {}, Linvoke_static_test;->returnUninitializedField()Ljava/lang/String;

    return-void
.end method

.method public static invokeMethodOutsideClassThatAccessesThisClass()V
    .locals 1

    invoke-static {}, Lclass_with_static_init;->getStaticFieldFromInvokeStaticTestClass()Ljava/lang/String;

    return-void
.end method

.method public static mutateStaticClassFieldNonDeterministically()V
    .locals 2

    sget-object v0, Linvoke_static_test;->mutable:[I

    sget v1, Lsome_unexistant_class;->fieldy:I
    if-eqz v1, :was_zero

    const/4 v1, 0x1
    aput v1, v0, v1

    :was_zero
    const/4 v1, 0x0
    aput v1, v0, v1

    return-void
.end method




.method private static returnUninitializedField()Ljava/lang/String;
    .locals 1

    sget-object v0, Linvoke_static_test;->not_initialized:Ljava/lang/String;
    return v0

    return-void
.end method

.method private static returnVoid()V
    .locals 0

    return-void
.end method

.method private static returnInt()I
    .locals 1

    const/4 v0, 0x7

    return v0
.end method

.method private static returnParameter(I)I
    .locals 1

    move v0, p0
    const-string p0, "can't trust p0"

    return v0
.end method

.method private static mutateString(Ljava/lang/String;)V
    .locals 0

    const-string p0, "mutated"

    return-void
.end method

.method private static mutateStringBuilder(Ljava/lang/StringBuilder;)V
    .locals 1

    const-string v0, " mutated"
    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/4 p0, 0x1 # ensure this works if the register is blasted away

    return-void
.end method

# test assumemaximum unknown
.method private static set0thElementOfFirstParameterTo0IfSecondParameterIs0([II)V
    .locals 1

    const v0, 0x0
    if-eq p1, v0, :eq_0
    goto :end

    :eq_0
    aput v0, p0, v0
    move v0, p0
    # wipe out p0 value to make sure we don't care about register index
    new-instance p0, Ljava/lang/StringBuilder;

    :end
    return-void
.end method

# Test case would have p0 == p1
.method private static set0thElementOfFirstParameterTo0IfThirdParameterIs0([I[II)V
    .locals 1

    const v0, 0x0
    if-eq p2, v0, :eq_0
    goto :end

    :eq_0
    aput v0, p0, v0
    const/4 p0, 0x1

    :end
    return-void
.end method

val longBits = Array(64) { 0x80000000uL shr it }
fun ULong.toBooleanArray() = BooleanArray(64) { (this and longBits[it]) == longBits[it] }
fun BooleanArray.toULong(): ULong {
	var long = 0uL
	for (i in this.indices)
		if (this[i])
			long = long or longBits[i]
	return long
}

fun BooleanArray.shift(offset: Int) { // shifting right by default
	if (offset > 0) {
		require(offset < 64)
		val buffer = BooleanArray(offset) { this[this.lastIndex - offset + it] }
		for ((i, j) in (offset until this.size).withIndex().reversed())
			this[j] = this[i]
		System.arraycopy(buffer, 0, this, 0, offset)
	} else {
		require(offset > -64)
		val buffer = BooleanArray(-offset) { this[it] }
		for ((i, j) in (-offset until this.size).withIndex())
			this[i] = this[j]
		System.arraycopy(buffer, 0, this, this.lastIndex - offset, offset)
	}
}

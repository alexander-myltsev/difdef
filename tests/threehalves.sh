cat >a <<EOF

void func1() {
    x += 1;
}

void func2() {
    x += 2;
}

EOF
cat >b <<EOF

void func1() {
    x += 1;
}

void threehalves() {
    x += 1.5;
}

void func2() {
    x += 2;
}

EOF

./difdef a b >out
cat >expected <<EOF
ab
abvoid func1() {
ab    x += 1;
ab}
 b
 bvoid threehalves() {
 b    x += 1.5;
 b}
ab
abvoid func2() {
ab    x += 2;
ab}
ab
EOF
diff expected out

./difdef -DV1 -DV2 a b >out
cat >expected <<EOF

void func1() {
    x += 1;
}

#ifdef V2
void threehalves() {
    x += 1.5;
}
#endif /* V2 */

void func2() {
    x += 2;
}

EOF
diff expected out

rm -f a b expected out

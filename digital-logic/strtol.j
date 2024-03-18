public static int strtol(char[] buffer, int radix) {
    int result;
    int value;
    int i;
    char $l;
    char $r;
    char glyph;

    result = 0;
    value = 0;

init:   ;
        i = 0;
        $l = buffer[i];
        $r = '\0';
loop:   for (; $l != $r ;) {
body:   ;
            glyph = $l;
            value = glyph2int(glyph, radix);
            if (value == -1) {
then8:  ;            
                break;
        }
alt5:   ;
//null
nextIf3:    ;        
        result = result * radix;
        result = result + value;
    }
next:   ;
        i = i + 1;
        $l = buffer[i];
        $r = '\0';
        continue loop;
done:   ;        
    return result;
}
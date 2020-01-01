//НИС — Сделать мыльницу 70х50х20 в OpenSCAD.

//Для удобного изменения координат. 
Delta = 1;

X = 70 * Delta;
Y = 50 * Delta;
Z = 20 * Delta;
//Изменение количества полигонов. 
//При 100 рендеринг: ~40 секунд.
//При 200 рендеринг: ~120 секунд.
 $fn=200;
 
// Функция, чтобы отрисовать ножку,
// которая выше оси координат.
module leg(legX,legY,legZ) {
    difference() {
        translate(v = [legX,legY,legZ]) {
            cylinder(Z,Z/6.7,Z/4);
        }
         $fn = 20;
        //Вырезам всё, что меньше 0.
        translate(v = [0,0,-Z]) {
            cube([X,Y,Z], false);
        }
    }
}

difference(){
union(){
translate(v = [X/2,Y/2,Z-Z/3.5]){difference(){

// Создаём сферу
scale([X/2,Y/2,Z/1.5]){sphere(1);}
 
// И вычитаем из неё куб 
        translate(v = [-X/2,-Y/2,Z/10]) {
            cube([X,Y,Z], false);
        }
}}

//Делаем ножки. 4 наклонённых цилиндра
leg(X/4,Y/4,-Z/2);
leg(3*X/4,Y/4,-Z/2);
leg(3*X/4,3*Y/4,-Z/2);
leg(X/4,3*Y/4,-Z/2);
}

//  ВЫЧИТАЕМ ДЫРОЧКУ ДЛЯ ВОДЫ.[Чтобы вода стекала обратно в раковину/ванну] 
    rotate([-76,0,0]) {translate(v = [X/2,0,-Z/7]) {
        cylinder(r=X/30, h=Z*1.5);
    }}
    rotate([-75,0,0]) {translate(v = [X/2 + X/10,0,-Z/7]) {
        cylinder(r=X/30, h=Z*1.5);
    }}
    rotate([-75,0,0]) {translate(v = [X/2 - X/10,0,-Z/7]) {
        cylinder(r=X/30, h=Z*1.5);
    }}
// ВЫЧИТАЕМ УГЛУБЛЕНИЕ.
    translate(v = [X/2,Y/2,2*Z + Z/15]){
        scale([X/1.70,Y/1.75,1.9*Z]){sphere(1);}}

}

// Для тестирования
/*
translate(v = [0,0,0]) {
    cube([X,Y,Z], false);
}*/
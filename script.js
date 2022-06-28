var c = document.querySelector("canvas");
c.width = window.innerWidth;
c.height = window.innerHeight;
var ctx = c.getContext('2d');


var locx,locy,r,grn,blu,red, dot,cntr,frqnc,start,s;
var pos_x,pos_y,color;
start = 0;
class point{
    constructor(x,y,col,s){
        this.pos_x=x;
        this.pos_y=y;
        this.color=col;
        this.size=s;
    }

    draw(){
        ctx.beginPath();
        ctx.rect(this.pos_x, this.pos_y, this.size, this.size);
        ctx.fillStyle=this.color;
        ctx.fill();
        ctx.closePath();
    }
}
locx=Math.round(Math.random()*c.width);
locy=Math.round(Math.random()*c.height);
console.log(locx,locy);

var clchk = document.getElementById('colorchk');
var frequency = document.getElementById('frqnc');
var update =document.getElementById('update');
var strt = document.getElementById('st');
var sz= document.getElementById('sz');


if(frequency.value.length == 0){
    update.disabled=true;
    console.log("dis")
}
else{
    update.disabled=false;
}

update.onclick = function(){
    frqnc=frequency.value;
    cntr=0;
}

strt.onclick = function(){
    if(start==0){
        start=1;
        strt.innerHTML = "Stop";
    }
    else{
        start=0;
        strt.innerHTML = "Start";
    }
}
cntr=0;
frqnc=1;



id = setInterval(() => {
    s = sz.value;
    if(frequency.value.length == 0){
        update.disabled=true;
    }
    else{
        update.disabled=false;
    }
    
    if(start == 1){
        update.onclick = function(){
            frqnc=frequency.value;
            cntr=0;
        }
    
        r=Math.ceil(Math.random()*4);
        var r1=Math.ceil(Math.random()*4);
        if(r==1){
            locx=locx+r1;
        }
        else if(r==2){
            locx=locx-r1;
        }
        else if(r==3){
            locy=locy+r1;
        }
        else if(r==4){
            locy=locy-r1;
        }
        else{
            // alert("out of range");
            console.log(r);
        }
    
        if(locx>c.width||locy>c.height){
            locx=locx-r1;
            locy=locy-r1;
        }
        else if(locx<0||locy<0){
            locx=locx+r1;
            locy=locy+r1;
        }
        cntr++;
        if(cntr == frqnc){
            if(clchk.checked==true){
                red = Math.random()*255;
                blu = Math.random()*255;
                grn = Math.random()*255;
            }
            else{
                var t=Math.random()*255;
                red=t;
                blu=t;
                grn=t;
            }
            cntr=0;
        }
    
    
        dot = new point(locx, locy, 'rgb('+red+','+grn+','+blu+')', s);
        dot.draw();
    }


}, 10);
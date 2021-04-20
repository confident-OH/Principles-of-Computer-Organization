#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
	char name[10] = "map.txt";
	int go[13][13];
	int charactor[13][13];
	memset(go, 0, sizeof(go));
	memset(charactor, 0, sizeof(charactor));
	freopen(name, "w", stdout);
	int i,j, result, x, y, color;
	//绘制棋盘横线 
	for(i=0; i<13; i++){
		y = 21+7*i;
		x = 20;
		for(j = 0; j<85; j++){
			x++;
			color = 0;
			result = x + (y<<8) + (color<<16); 
			result = result | (1<<31);
			printf("%.8x\n", result);
		}
	}
	//绘制棋盘竖线 
	for(i=0; i<13; i++){
		x = 21+7*i;
		y = 20;
		for(j = 0; j<85; j++){
			y++;
			color = 0;
			result = x + (y<<8) + (color<<16); 
			result = result | (1<<31);
			printf("%.8x\n", result);
		}
	}
	//模拟绘制棋子
	for(i = 0; i<5; i++){
		x = i;
		y = i;
		if(go[x][y] == 0){
			go[x][y] = 1;
			charactor[x][y] = 1;
		}
		result = (20+7*x) + ((19+7*y)<<8) + (charactor[x][y]<<16);
		result = result | (1<<31);
		printf("%.8x\n", result);
		result++;
		printf("%.8x\n", result);
		result--;
		printf("%.8x\n", result);
		result += 0x100;
		printf("%.8x\n", result);
		result++;
		printf("%.8x\n", result);
		result++;
		printf("%.8x\n", result);
		result++;
		printf("%.8x\n", result);
		
	}
	return 0;
} 

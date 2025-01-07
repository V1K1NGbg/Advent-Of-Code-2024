// gcc -o 20.1 20.1.c
// ./20.1

#include <stdio.h>
#include <stdlib.h>

#define INPUT_FILE "input/20.txt"

#define ROWS 141
#define COLS 141

// QUEUE

struct node {
  int row, col, steps;
};

struct queue {
  struct node *items;
  int front, rear;
  int size;
};

void queueInit(struct queue *q, int size) {
  q->items = (struct node *)malloc(size * sizeof(struct node));
  q->size = size;
  q->front = q->rear = 0;
}

void queueFree(struct queue *q) { free(q->items); }

void enqueue(struct queue *q, int row, int col, int steps) {
  if ((q->rear + 1) % q->size == q->front) {
    printf("Queue is full\n");
    return;
  }
  q->items[q->rear].row = row;
  q->items[q->rear].col = col;
  q->items[q->rear].steps = steps;

  q->rear = (q->rear + 1) % q->size;
}

struct node *dequeue(struct queue *q) {
  if (q->front == q->rear) {
    return NULL;
  }
  struct node *item = &q->items[q->front];
  q->front = (q->front + 1) % q->size;
  return item;
}

int isEmpty(struct queue *q) { return q->front == q->rear; }

// QUEUE

int sr, sc, er, ec;

char map[ROWS][COLS];

void readFile(FILE *fp) {
  int row = 0, col = 0;
  int ch;
  while ((ch = fgetc(fp)) != EOF) {
    if (ch == '\n') {
      row++;
      col = 0;
      continue;
    }
    if (ch == 'S') {
      sr = row;
      sc = col;
    }
    if (ch == 'E') {
      er = row;
      ec = col;
    }
    map[row][col] = ch;
    col++;
  }
}

int bfs(void) {
  int dr[] = {0, 0, 1, -1};
  int dc[] = {1, -1, 0, 0};

  int visited[ROWS][COLS] = {0};

  int steps = 0;

  struct queue q;
  queueInit(&q, 1024);
  enqueue(&q, sr, sc, 0);

  visited[sr][sc] = 1;

  while (!isEmpty(&q)) {
    struct node *item = dequeue(&q);
    int cr = item->row;
    int cc = item->col;

    for (int i = 0; i < 4; i++) {
      int nr = cr + dr[i];
      int nc = cc + dc[i];

      if (nr < 0 || nr >= ROWS || nc < 0 || nc >= COLS) {
        continue;
      }

      if (map[nr][nc] == '#') {
        continue;
      }

      if (visited[nr][nc]) {
        continue;
      }

      visited[nr][nc] = 1;

      if (nr == er && nc == ec) {
        return item->steps + 1;
      }

      enqueue(&q, nr, nc, item->steps + 1);
    }
  }
  queueFree(&q);
  return steps;
}

int main(void) {
  FILE *fp = fopen(INPUT_FILE, "r");

  readFile(fp);

  int ans = 0;
  int base = bfs();

  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLS; j++) {
      if (map[i][j] == '#') {
        map[i][j] = '.';
        int temp = bfs();
        if (base - temp >= 100) {
          ans++;
        }
        map[i][j] = '#';
      }
    }
  }

  printf("%d\n", ans);

  fclose(fp);
  return 0;
}
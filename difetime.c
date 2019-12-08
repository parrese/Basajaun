#include <stdio.h>
struct TIME
{
  int seconds;
  int minutes;
  int hours;
};
void differenceBetweenTimePeriod(struct TIME t1, struct TIME t2, struct TIME *diff);
int main()
{
    struct TIME startTime, stopTime, diff;
    printf("Introduce el momento inicial: \n");
    printf("Introduce hora, minutos y segundos respectivamente (separados por un  Intro): ");
    scanf("%d %d %d", &startTime.hours, &startTime.minutes, &startTime.seconds);
    printf("Introduce el momento final: \n");
    printf("Introduce hora, minutos y segundos respectivamente (separados por un Intro: ");
    scanf("%d %d %d", &stopTime.hours, &stopTime.minutes, &stopTime.seconds);
    // Calcula la diferencia entre los momentos inicial y final.
    differenceBetweenTimePeriod(startTime, stopTime, &diff);
    printf("\nDIFERENCIA HORARIA: %d:%d:%d - ", startTime.hours, startTime.minutes, startTime.seconds);
    printf("%d:%d:%d ", stopTime.hours, stopTime.minutes, stopTime.seconds);
    printf("= %d:%d:%d\n", diff.hours, diff.minutes, diff.seconds);
    return 0;
}
void differenceBetweenTimePeriod(struct TIME start, struct TIME stop, struct TIME *diff)
{
    if(stop.seconds > start.seconds){
        --start.minutes;
        start.seconds += 60;
    }
    diff->seconds = start.seconds - stop.seconds;
    if(stop.minutes > start.minutes){
        --start.hours;
        start.minutes += 60;
    }
    diff->minutes = start.minutes - stop.minutes;
    diff->hours = start.hours - stop.hours;
}

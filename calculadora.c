#include <stdio.h>
int main() {
    char operador;
    double primero, segundo;
    printf("Introduce un operador (+, -, *, /): ");
    scanf("%c", &operador);
    printf("Introduce los dos operandos separados por un Intro (decimales separados por un punto): ");
    scanf("%lf %lf", &primero, &segundo);
    switch (operador) {
    case '+':
        printf("%.1lf + %.1lf = %.1lf", primero, segundo, primero + segundo);
        break;
    case '-':
        printf("%.1lf - %.1lf = %.1lf", primero, segundo, primero - segundo);
        break;
    case '*':
        printf("%.1lf * %.1lf = %.1lf", primero, segundo, primero * segundo);
        break;
    case '/':
        printf("%.1lf / %.1lf = %.1lf", primero, segundo, primero / segundo);
        break;
        // Si el operador no encuentra una constante
    default:
        printf("¡Error! El operador no es correcto");
    }
    return 0;
}

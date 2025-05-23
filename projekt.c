#include <stdio.h>

extern float pi_asm(int n);

int main()
{
    int decimal_places;
    char continue_program;

    do
    {
        do
        {
            printf("Podaj liczbe cyfr po przecinku (musi byc > 1 i <= 6): ");
            if (scanf("%d", &decimal_places) != 1)
            {
                printf("Niepoprawne dane. Prosze podac poprawna liczbe calkowita.\n");
                while (getchar() != '\n')
                    ;
                decimal_places = 0;
            }
            else if (decimal_places <= 1 || decimal_places > 6)
            {
                printf("Niepoprawne dane. Prosze podac wartosc wieksza niz 1 i mniejsza lub rowna 6.\n");
            }
            else
            {
                while (getchar() != '\n')
                    ;
                break;
            }
        } while (decimal_places <= 1 || decimal_places > 6);

        float pi = pi_asm(1000000);

        printf("Wartosc liczby PI: %.*f\n", decimal_places, pi);

        do
        {
            printf("Czy chcesz kontynuowac? (t/n): ");
            if (scanf(" %c", &continue_program) != 1)
            {
                printf("Niepoprawne dane. Prosze wpisac 't' lub 'n'.\n");
                while (getchar() != '\n')
                    ;
                continue_program = '\0';
            }
            else if (continue_program != 't' && continue_program != 'n')
            {
                printf("Niepoprawne dane. Prosze wpisac 't' lub 'n'.\n");
                while (getchar() != '\n')
                    ;
            }
            else
            {
                while (getchar() != '\n')
                    ;
                break;
            }
        } while (continue_program != 't' && continue_program != 'n');

    } while (continue_program == 't');

    printf("Program zakonczony.\n");

    return 0;
}

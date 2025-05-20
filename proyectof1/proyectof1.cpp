// ===============================
// Cheety - Chatbot Musical en C++
// ===============================

#include <iostream>
#include <fstream>
#include <sstream>
#include <regex>
#include <map>
#include <mysql.h>
#include <iomanip>
#include <algorithm>
#include "conexionBD.h"

using namespace std;

// -------------------------------
// Constantes de formato
// -------------------------------
const int CONSOLE_WIDTH = 100;
const string COLOR_USUARIO = "\033[35m";  // Rosa
const string COLOR_BOT = "\033[0;36m";    // Celeste
const string COLOR_RESET = "\033[0m";

// -------------------------------
// Funciones de utilidad
// -------------------------------

// Normaliza un texto eliminando tildes, signos de interrogación y convirtiendo a minúsculas
string normalizar(const string& entrada) {
    string salida;
    for (char c : entrada) {
        c = tolower(c);
        switch (c) {
        case 'á': case 'Á': c = 'a'; break;
        case 'é': case 'É': c = 'e'; break;
        case 'í': case 'Í': c = 'i'; break;
        case 'ó': case 'Ó': c = 'o'; break;
        case 'ú': case 'Ú': c = 'u'; break;
        }
        if (c != '¿' && c != '?') salida += c;
    }
    return salida;
}

// Carga el archivo de conocimiento y lo guarda en un map normalizado
map<string, string> cargarConocimientoDesdeArchivo(const string& nombreArchivo) {
    map<string, string> conocimiento;
    ifstream archivo(nombreArchivo);
    string linea;

    while (getline(archivo, linea)) {
        size_t sep = linea.find('|');
        if (sep != string::npos) {
            string pregunta = linea.substr(0, sep);
            string respuesta = linea.substr(sep + 1);
            conocimiento[normalizar(pregunta)] = respuesta;
        }
    }
    return conocimiento;
}

// Intenta extraer el nombre del artista de la pregunta
string extraerArtista(const string& pregunta) {
    regex patron(R"(.*(canciones|temas).*(de|del|que tiene)\s+(.+))", regex::icase);
    smatch coincidencias;
    if (regex_search(pregunta, coincidencias, patron)) {
        return coincidencias[3].str();
    }
    return "";
}

// Consulta canciones de un artista desde la base de datos
void responderDesdeBD(MYSQL* con, const string& artista) {
    string consulta =
        "SELECT c.titulo, c.duracion, a.titulo, g.nombre "
        "FROM cancion c "
        "JOIN album a ON c.album_id = a.id_album "
        "JOIN artista ar ON a.artista_id = ar.id_artista "
        "JOIN genero g ON ar.genero_id = g.id_genero "
        "WHERE ar.nombre = '" + artista + "';";

    if (mysql_query(con, consulta.c_str()) == 0) {
        MYSQL_RES* resultado = mysql_store_result(con);
        MYSQL_ROW fila;
        int filas = mysql_num_rows(resultado);

        if (filas == 0) {
            cout << COLOR_BOT << "🤖 No encontré canciones de " << artista << "." << COLOR_RESET << endl;
        }
        else {
            cout << COLOR_BOT << "🤖 Canciones de " << artista << ":\n";
            while ((fila = mysql_fetch_row(resultado))) {
                cout << "- " << fila[0] << " | Álbum: " << fila[2]
                    << " | Duración: " << fila[1]
                    << " | Género: " << fila[3] << endl;
            }
            cout << COLOR_RESET;
        }

        mysql_free_result(resultado);
    }
    else {
        cerr << " Error en la consulta: " << mysql_error(con) << endl;
    }
}

// -------------------------------
// Función principal
// -------------------------------

int main() {
    // Conexión a la base de datos
    conexionBD cn;
    cn.abrir_conexion();
    MYSQL* con = cn.getConector();

    if (!con) {
        cerr << "No se pudo conectar a la base de datos." << endl;
        return 1;
    }

    // Cargar archivo de conocimiento
    map<string, string> conocimiento = cargarConocimientoDesdeArchivo("conocimiento.txt");

    cout << COLOR_BOT << "🤖🎤 Hola, soy Cheety, tu IA musical. Escribe 'salir' para terminar.\n" << COLOR_RESET;

    // Bucle de interacción
    string pregunta;
    while (true) {
        cout << COLOR_USUARIO << "Tú: " << COLOR_RESET;
        getline(cin, pregunta);
        if (pregunta == "salir") break;

        // Mostrar alineado a la derecha
        cout << right << setw(CONSOLE_WIDTH) << COLOR_USUARIO + "👤 " + pregunta + COLOR_RESET << endl;

        string pregunta_normalizada = normalizar(pregunta);

        // Respuesta desde conocimiento.txt
        if (conocimiento.count(pregunta_normalizada)) {
            cout << COLOR_BOT << "🤖 " << conocimiento[pregunta_normalizada] << COLOR_RESET << endl;
            continue;
        }

        // Respuesta desde base de datos
        string artista = extraerArtista(pregunta_normalizada);
        if (!artista.empty()) {
            responderDesdeBD(con, artista);
            continue;
        }

        // Si no encuentra coincidencias
        cout << COLOR_BOT << "🤖 Lo siento, no tengo una respuesta para eso." << COLOR_RESET << endl;
    }

    // Cierre de conexión
    cn.cerrar_conexion();
    return 0;
}
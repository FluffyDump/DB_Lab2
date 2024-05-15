import mysql.connector, re
from flask import Flask, jsonify, request
from datetime import datetime

HOST = '127.0.0.1'
PORT = '3306'
DATABASE = 'bankas'
USERNAME = 'root'

connection_string = {
    'host': HOST,
    'port': PORT,
    'database': DATABASE,
    'user': USERNAME,
    'charset': 'utf8mb4',
    'ssl_disabled': True
}

app = Flask(__name__)

sql_connection = mysql.connector.connect(**connection_string)

if sql_connection.is_connected():
    print("Connected")
else:
    print("Failed to connect")

@app.route("/get_F1", methods=["POST"])
async def get_F1():
    try:
        json_content = request.get_json()
        table_B_name = json_content['main']
        table_B_fk = json_content['main_fk']
        table_A_name = json_content['additional']
        table_A_pk = json_content['additional_pk']
        order_by = json_content['order_by']

        cursor = sql_connection.cursor()
        cursor.execute(f"SELECT * FROM {table_B_name} ORDER BY {order_by}")
        table_B_data = cursor.fetchall();
    
        if not table_B_data:
            return FileNotFoundError, 404
        
        combined_data = []

        fk_index = cursor.column_names.index(table_B_fk)
        for row in table_B_data:
            fk_value = row[fk_index]
            cursor.execute(f"SELECT * FROM {table_A_name} WHERE {table_A_pk} = %s", (fk_value,))
            additional_data = cursor.fetchone()

            combined_row_data = {
                "table_B_data": str(row),
                "table_A_data": str(additional_data)
            }
            combined_data.append(combined_row_data)
        return jsonify(combined_data), 200, {'Content-Type': 'application/json; charset=utf-8', 'json-escape': False}
    except Exception as ex:
        return jsonify({'error': str(ex)}), 500
    
@app.route("/get_account/<account_number>", methods=["GET"])
def get_account_data(account_number):
    try:
        cursor = sql_connection.cursor(dictionary=True)
        cursor.execute(f"SELECT * FROM banko_saskaitos WHERE Saskaitos_numeris = '{account_number}'")
        account_data = cursor.fetchone()
        cursor.close()
        return account_data
    except Exception as ex:
        print(f"Error fetching account data: {ex}")
        return None
    
    
@app.route("/get_clients", methods=["GET"])
def get_clients():
    cursor = sql_connection.cursor(dictionary=True)
    cursor.execute("SELECT kliento_ID, asmens_kodas FROM klientai")
    client_data = cursor.fetchall()
    cursor.close()
    
    client_list = []
    for client in client_data:
        client_info = f"ID: {client['kliento_ID']} | a.k. {client['asmens_kodas']}"
        client_list.append(client_info)
    
    if client_list:
        return jsonify({'clients': client_list}), 200
    
@app.route("/get_client/<account_number>", methods=["GET"])
async def get_client(account_number):
    try:
        if account_number:
            cursor = sql_connection.cursor(dictionary=True)
            cursor.execute(f"SELECT fk_klientaskliento_ID FROM banko_saskaitos WHERE saskaitos_numeris = '{account_number}' ")
            kliento_ID_field = cursor.fetchone()
            kliento_ID = kliento_ID_field['fk_klientaskliento_ID']

            cursor.execute(f"SELECT kliento_ID, asmens_kodas FROM klientai WHERE kliento_ID = {kliento_ID}")
            klientas = cursor.fetchone()

            client_info = f"ID: {klientas['kliento_ID']} | a.k. {klientas['asmens_kodas']}"

            cursor.close()
            return jsonify(client_info), 200
        else:
            return "", 404
    except Exception as ex:
        return jsonify({'error': str(ex)}), 200
    
@app.route("/get_account_contracts/<account_number>", methods=["GET"])
async def get_account_contracts(account_number):
    try:
        if account_number:
            cursor = sql_connection.cursor(dictionary=True)
            cursor.execute(f"SELECT sutarties_ID, sutarties_tipas, data, busena FROM sutartis WHERE fk_banko_saskaitasaskaitos_numeris = '{account_number}' ")
            sutartys = cursor.fetchall()

            data_list = []

            for sutartis in sutartys:
                sutarties_ID = sutartis['sutarties_ID']
                cursor.execute(f"SELECT fk_darbuotojasdarbuotojo_ID FROM patvirtina WHERE fk_sutartissutarties_ID = {sutarties_ID} ")
                darbuotojo_ID = cursor.fetchone()
                ID = darbuotojo_ID['fk_darbuotojasdarbuotojo_ID']
                cursor.execute(f"SELECT asmens_kodas FROM darbuotojai WHERE darbuotojo_ID = {ID} ")
                darbuotojo_asmens_kodas = cursor.fetchone()
                darbuotojas = f"ID: {ID} | a.k. {darbuotojo_asmens_kodas['asmens_kodas']}"
                ID = sutartis['sutarties_ID']
                str_ID = str(ID)
                data_list.append((str_ID, sutartis['sutarties_tipas'], sutartis['data'], sutartis['busena'], darbuotojas))
            cursor.close()
            return data_list, 200
        else:
            return "", 404
    except Exception as ex:
        return jsonify({'error': str(ex)}), 500
    
@app.route("/get_workers", methods=["GET"])
def get_workers():
    cursor = sql_connection.cursor(dictionary=True)
    cursor.execute("SELECT darbuotojo_ID, asmens_kodas FROM darbuotojai")
    worker_data = cursor.fetchall()
    cursor.close()
    
    worker_list = []
    for worker in worker_data:
        client_info = f"ID: {worker['darbuotojo_ID']} | a.k. {worker['asmens_kodas']}"
        worker_list.append(client_info)
    
    if worker_list:
        return jsonify({'workers': worker_list}), 200
    
@app.route("/remove_F1_account/<account_number>", methods=["GET"])
def remove_F1_account(account_number):
    cursor = sql_connection.cursor()
    try:
        cursor.execute(f"SELECT * FROM banko_saskaitos WHERE Saskaitos_numeris = '{account_number}'")
        account_data = cursor.fetchone()
        if account_data:
            saskaitos_numeris = account_data[0]
            kliento_ID = account_data[7]

            cursor.execute(f"SELECT sutarties_ID FROM sutartis WHERE fk_banko_saskaitasaskaitos_numeris = '{saskaitos_numeris}'")
            sutartys = cursor.fetchall()

            for sutartis in sutartys:
                sutarties_ID = sutartis[0]
                cursor.execute(f"DELETE FROM patvirtina WHERE fk_sutartissutarties_ID = {sutarties_ID}")

                cursor.execute(f"SELECT id_uzsakyta_paslauga FROM uzsakytos_paslaugos WHERE fk_sutartissutarties_ID = {sutarties_ID}")
                uzsakytos_paslaugos = cursor.fetchall()
                for uzsakyta_paslauga in uzsakytos_paslaugos:
                    uzsakytos_paslaugos_ID = uzsakyta_paslauga[0]
                    cursor.execute(f"SELECT fk_paslaugapavadinimas FROM pateikiama WHERE fk_uzsakyta_paslaugaid_uzsakyta_paslauga = {uzsakytos_paslaugos_ID}")
                    paslaugos = cursor.fetchall()
                    for paslauga in paslaugos:
                        pavadinimas = paslauga[0]
                        cursor.execute(f"DELETE FROM paslaugos WHERE pavadinimas = '{pavadinimas}'")
                    cursor.execute(f"DELETE FROM pateikiama WHERE fk_uzsakyta_paslaugaid_uzsakyta_paslauga = {uzsakytos_paslaugos_ID}")
                    cursor.execute(f"DELETE FROM uzsakytos_paslaugos WHERE id_uzsakyta_paslauga = {uzsakytos_paslaugos_ID}")
                cursor.execute(f"DELETE FROM indelis WHERE fk_sutartissutarties_ID = {sutarties_ID}")
                cursor.execute(f"DELETE FROM paskola WHERE fk_sutartissutarties_ID = {sutarties_ID}")

            cursor.execute(f"DELETE FROM sutartis WHERE fk_banko_saskaitasaskaitos_numeris = '{saskaitos_numeris}'")
            cursor.execute(f"DELETE FROM pavedimai WHERE fk_banko_saskaitasaskaitos_numeris = '{account_number}'")
            cursor.execute(f"DELETE FROM banko_saskaitos WHERE Saskaitos_numeris = '{account_number}'")
            
            cursor.execute(f"SELECT * FROM banko_saskaitos WHERE fk_klientaskliento_ID = '{kliento_ID}'")
            kliento_paskyros = cursor.fetchall()

            if not kliento_paskyros:
                #cursor.execute(f"DELETE FROM klientai WHERE kliento_ID = {kliento_ID}")
                sql_connection.commit()
                cursor.fetchall()
                cursor.close()
                return "Can't remove client itself!", 200
            
            sql_connection.commit()
            cursor.fetchall()
            cursor.close()
            return "ok", 200
        return "Account not found!", 404
    except Exception as ex:
        cursor.close()
        print(f"Error fetching account data: {ex}")
        sql_connection.rollback()
        return None, 500
    
@app.route("/get_accout_type", methods=["GET"])
def get_accout_type():
    try:
        cursor = sql_connection.cursor()
        cursor.execute("SELECT column_type FROM information_schema.columns WHERE table_name = 'banko_saskaitos' AND column_name = 'saskaitos_tipas';")
        enum_values_str = cursor.fetchone()[0]
        enum_values = [value.strip("'") for value in enum_values_str.strip("enum(").strip(")").split(",")]
        cursor.close()
        return jsonify({'saskaitos_tipas': enum_values}), 200
    except Exception as ex:
        return jsonify({'error': str(ex)}), 500
    
@app.route("/get_currency", methods=["GET"])
def get_currency():
    try:
        cursor = sql_connection.cursor()
        cursor.execute("SELECT column_type FROM information_schema.columns WHERE table_name = 'banko_saskaitos' AND column_name = 'valiuta';")
        enum_values_str = cursor.fetchone()[0]
        enum_values = [value.strip("'") for value in enum_values_str.strip("enum(").strip(")").split(",")]
        cursor.close()
        return jsonify({'valiuta': enum_values}), 200
    except Exception as ex:
        return jsonify({'error': str(ex)}), 500
    
@app.route("/get_contracts", methods=["GET"])
def get_contracts():
    try:
        cursor = sql_connection.cursor()
        cursor.execute("SELECT column_type FROM information_schema.columns WHERE table_name = 'sutartis' AND column_name = 'sutarties_tipas';")
        enum_values_str = cursor.fetchone()[0]
        enum_values = [value.strip("'") for value in enum_values_str.strip("enum(").strip(")").split(",")]
        cursor.close()
        return jsonify({'sutartis': enum_values}), 200
    except Exception as ex:
        return jsonify({'error': str(ex)}), 500
    
@app.route("/get_status", methods=["GET"])
def get_status():
    try:
        cursor = sql_connection.cursor()
        cursor.execute("SELECT column_type FROM information_schema.columns WHERE table_name = 'sutartis' AND column_name = 'busena';")
        enum_values_str = cursor.fetchone()[0]
        enum_values = [value.strip("'") for value in enum_values_str.strip("enum(").strip(")").split(",")]
        cursor.close()
        return jsonify({'busena': enum_values}), 200, {'Content-Type': 'application/json; charset=utf-8', 'json-escape': False}
    except Exception as ex:
        return jsonify({'error': str(ex)}), 500
    
@app.route('/edit_account_contract', methods=['POST'])
def edit_account_contract():
    try:
        json_content = request.get_json()
        if json_content is None:
            return jsonify({'error': 'Invalid JSON payload'}), 400
        
        saskaita_data = json_content.get('bankoSaskaitaData')
        for key, value in saskaita_data.items():
            if value is None:
                saskaita_data[key] = 'NULL'
                
        if len(str(saskaita_data['balansas'])) > 12 or len(str(saskaita_data['dienos_limitas'])) > 12 or len(str(saskaita_data['savaites_limitas'])) > 12 or len(str(saskaita_data['menesio_limitas'])) > 12:
            return "Neteisingi reikšmių ilgiai!", 400
        
        cursor = sql_connection.cursor()
        cursor.execute(f"UPDATE banko_saskaitos SET balansas = {saskaita_data['balansas']}, dienos_limitas = {saskaita_data['dienos_limitas']}, savaites_limitas = {saskaita_data['savaites_limitas']}, menesio_limitas = {saskaita_data['menesio_limitas']}, saskaitos_tipas = '{saskaita_data['saskaitos_tipas']}', valiuta = '{saskaita_data['valiuta']}' WHERE saskaitos_numeris = '{saskaita_data['saskaitos_numeris']}'")

        sutartys = json_content['sutartys']

        cursor.execute(f"SELECT fk_klientaskliento_ID FROM banko_saskaitos WHERE saskaitos_numeris = '{saskaita_data['saskaitos_numeris']}'")
        kliento_ID = cursor.fetchone()[0]

        panaudotos_ID_reiksmes = []
        for sutartis in sutartys:
            data_str = sutartis['data']
            data_obj = datetime.fromisoformat(data_str)
            formatted_date = data_obj.strftime('%Y-%m-%d')
            darbuotojas = sutartis['pasirinktasDarbuotojas']
            darbuotojo_ID = darbuotojas.split()[1]
            if sutartis['sutarties_ID'] is not None:
                panaudotos_ID_reiksmes.append(int(sutartis['sutarties_ID']))
                cursor.execute(f"UPDATE sutartis SET sutarties_tipas = '{sutartis['sutarties_tipas']}', data = '{formatted_date}', busena = '{sutartis['busena']}' WHERE sutarties_ID = {sutartis['sutarties_ID']}")
                cursor.execute(f"UPDATE patvirtina SET fk_darbuotojasdarbuotojo_ID = {darbuotojo_ID} WHERE fk_sutartissutarties_ID = {sutartis['sutarties_ID']}")
            else:
                cursor.execute(f"INSERT INTO sutartis (kliento_ID, data, sutarties_tipas, busena, fk_banko_saskaitasaskaitos_numeris) VALUES ({kliento_ID}, '{formatted_date}', '{sutartis['sutarties_tipas']}', '{sutartis['busena']}', '{saskaita_data['saskaitos_numeris']}')")
                new_sutarties_ID = cursor.lastrowid
                panaudotos_ID_reiksmes.append(new_sutarties_ID)
                cursor.execute(f"INSERT INTO patvirtina (fk_sutartissutarties_ID, fk_darbuotojasdarbuotojo_ID) VALUES ({new_sutarties_ID}, {darbuotojo_ID})")

        cursor.execute(f"SELECT sutarties_ID FROM sutartis WHERE fk_banko_saskaitasaskaitos_numeris = '{saskaita_data['saskaitos_numeris']}'")
        kliento_sutartys = cursor.fetchall()

        for kliento_sutartis in kliento_sutartys:
            sutarties_ID = kliento_sutartis[0]

            if sutarties_ID not in panaudotos_ID_reiksmes:
                cursor.execute(f"DELETE FROM patvirtina WHERE fk_sutartissutarties_ID = {sutarties_ID}")
                cursor.execute(f"DELETE FROM indelis WHERE fk_sutartissutarties_ID = {sutarties_ID}")
                cursor.execute(f"DELETE FROM paskola WHERE fk_sutartissutarties_ID = {sutarties_ID}")
        
                cursor.execute(f"SELECT id_uzsakyta_paslauga FROM uzsakytos_paslaugos WHERE fk_sutartissutarties_ID = {sutarties_ID}")
                uzsakytos_paslaugos = cursor.fetchall()
                for uzsakyta_paslauga in uzsakytos_paslaugos:
                    uzsakytos_paslaugos_ID = uzsakyta_paslauga[0]
                    cursor.execute(f"DELETE FROM pateikiama WHERE fk_uzsakyta_paslaugaid_uzsakyta_paslauga = {uzsakytos_paslaugos_ID}")
                    cursor.execute(f"DELETE FROM uzsakytos_paslaugos WHERE id_uzsakyta_paslauga = {uzsakytos_paslaugos_ID}")

                cursor.execute(f"DELETE FROM sutartis WHERE sutarties_ID = {sutarties_ID}")
        sql_connection.commit()
        cursor.close()
        return "ok", 200
    except Exception as ex:
        cursor.close()
        sql_connection.rollback()
        print(str(ex))
        return jsonify({'error': str(ex)}), 500
    
@app.route('/add_account_contract', methods=['POST'])
def add_account_contract():
    try:
        json_content = request.get_json()
        if json_content is None:
            return jsonify({'error': 'Invalid JSON payload'}), 400
        
        bankoSaskaitaData = json_content.get('bankoSaskaitaData')
        for key, value in bankoSaskaitaData.items():
            if value is None:
                bankoSaskaitaData[key] = 'NULL'

        pasirinktasKlientas = json_content.get('pasirinktasKlientas')
        sutartys = json_content.get('sutartys')
        pasirinktasDarbuotojas = json_content.get('pasirinktasDarbuotojas')

        cursor = sql_connection.cursor()
        saskaitos_numeris = bankoSaskaitaData['saskaitos_numeris']
        cursor.execute(f"SELECT * FROM banko_saskaitos WHERE saskaitos_numeris = '{saskaitos_numeris}'")
        existingAccountNumber = cursor.fetchone();

        if not existingAccountNumber:
            balansas = bankoSaskaitaData['balansas']
            dienos_limitas = bankoSaskaitaData['dienos_limitas']
            savaites_limitas = bankoSaskaitaData['savaites_limitas']
            menesio_limitas = bankoSaskaitaData['menesio_limitas']

            balansas_str = "{:.0f}".format(balansas)
            if len(balansas_str) > 10:
                    cursor.close()
                    sql_connection.rollback()
                    return "Neteisingi reikšmių ilgiai!", 400
            if dienos_limitas != 'NULL':
                dienos_limitas_str = "{:.0f}".format(dienos_limitas)
                if len(dienos_limitas_str) > 10:
                    cursor.close()
                    sql_connection.rollback()
                    return "Neteisingi reikšmių ilgiai!", 400
            if savaites_limitas != 'NULL':
                savaites_limitas_str = "{:.0f}".format(savaites_limitas)
                if len(savaites_limitas_str) > 10:
                    cursor.close()
                    sql_connection.rollback()
                    return "Neteisingi reikšmių ilgiai!", 400
            if menesio_limitas != 'NULL':
                menesio_limitas_str = "{:.0f}".format(menesio_limitas)
                if len(menesio_limitas_str) > 10:
                    cursor.close()
                    sql_connection.rollback()
                    return "Neteisingi reikšmių ilgiai!", 400

            saskaitos_tipas = bankoSaskaitaData['saskaitos_tipas']
            valiuta = bankoSaskaitaData['valiuta']
            kliento_ID = pasirinktasKlientas.split(": ")[1].split(" |")[0]
            kliento_ID = int(kliento_ID)
            cursor.execute(f"INSERT INTO banko_saskaitos (saskaitos_numeris, balansas, dienos_limitas, savaites_limitas, menesio_limitas, saskaitos_tipas, valiuta, fk_klientaskliento_ID) VALUES ('{saskaitos_numeris}', {balansas}, {dienos_limitas}, {savaites_limitas}, {menesio_limitas}, '{saskaitos_tipas}', '{valiuta}', {kliento_ID})")
            sql_connection.commit();

            if sutartys:
                for sutartis, darbuotojas in zip(sutartys, pasirinktasDarbuotojas):
                    sutarties_tipas = sutartis['sutarties_tipas']
                    data = sutartis['data']
                    data_datetime = datetime.fromisoformat(data)
                    formatuota_data = data_datetime.strftime("%Y-%m-%d")
                    busena = sutartis['busena']
                    cursor.execute(f"INSERT INTO sutartis (kliento_ID, data, sutarties_tipas, busena, fk_banko_saskaitasaskaitos_numeris) VALUES ({kliento_ID}, '{formatuota_data}', '{sutarties_tipas}', '{busena}', '{saskaitos_numeris}')")
                    sql_connection.commit();
                    sutarties_ID = cursor.lastrowid
                    darbuotojo_id = darbuotojas.split(": ")[1].split(" |")[0]
                    cursor.execute(f"INSERT INTO patvirtina (fk_sutartissutarties_ID, fk_darbuotojasdarbuotojo_ID) VALUES ({sutarties_ID}, {darbuotojo_id})")
                    sql_connection.commit();
                return "ok", 200
            return "ok", 200
        return "ok", 400
    except Exception as ex:
        print(str(ex))
        return jsonify({'error': str(ex)}), 500
    
@app.route('/get_custom_data', methods=['POST'])
def get_custom_data():
    json_content = request.get_json()
    if not json_content:
        return jsonify({'error': 'Invalid JSON payload'}), 400
    
    minData = json_content['minData']
    minDate = datetime.fromisoformat(minData)

    maxData = json_content['maxData']
    maxDate = datetime.fromisoformat(maxData)

    accountType = json_content['accountType']

    cursor = sql_connection.cursor()

    cursor.execute("""
        SELECT
            klientai.vardas,
            klientai.pavarde,
            banko_saskaitos.saskaitos_numeris,
            COUNT(sutartis.sutarties_ID) AS sutartys_skaicius,
            SUM(CASE WHEN sutartis.sutarties_tipas = 'paskola' THEN 1 ELSE 0 END) AS paskolos_skaicius,
            SUM(CASE WHEN sutartis.sutarties_tipas = 'indelis' THEN 1 ELSE 0 END) AS indeliu_skaicius,
            AVG(klientai.menesio_pajamos) AS vidutines_pajamos,
            MAX(sutartis.data) AS naujausia_sutarties_data,
            MIN(sutartis.data) AS seniausia_sutarties_data
        FROM
            klientai
        LEFT JOIN
            banko_saskaitos ON klientai.kliento_ID = banko_saskaitos.fk_klientaskliento_ID
        LEFT JOIN
            sutartis ON banko_saskaitos.saskaitos_numeris = sutartis.fk_banko_saskaitasaskaitos_numeris
        LEFT JOIN
            Patvirtina ON sutartis.sutarties_ID = Patvirtina.fk_sutartissutarties_ID
        LEFT JOIN
            darbuotojai ON Patvirtina.fk_darbuotojasdarbuotojo_ID = darbuotojai.darbuotojo_ID
        WHERE
            sutartis.data >= %s
            AND sutartis.data <= %s
            AND banko_saskaitos.saskaitos_tipas = %s
        GROUP BY
            klientai.vardas,
            klientai.pavarde,
            banko_saskaitos.saskaitos_numeris
    """, (minDate, maxDate, accountType))

    data = cursor.fetchall()
    cursor.close()

    data_list = []
    for line in data:
        worker_info = {
            'vardas': line['vardas'],
            'pavarde': line['pavarde'],
            'saskaitos_numeris': line['saskaitos_numeris'],
            'sutartys_skaicius': line['sutartys_skaicius'],
            'paskolos_skaicius': line['paskolos_skaicius'],
            'indeliu_skaicius': line['indeliu_skaicius'],
            'vidutines_pajamos': line['vidutines_pajamos'],
            'naujausia_sutarties_data': line['naujausia_sutarties_data'].strftime("%Y-%m-%d"),
            'seniausia_sutarties_data': line['seniausia_sutarties_data'].strftime("%Y-%m-%d")
        }
        data_list.append(worker_info)

    return jsonify({'workers': data_list}), 200


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5001, use_reloader=True)
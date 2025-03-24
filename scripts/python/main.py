import time
import pymsteams
import requests
import sqlalchemy
import pandas as pd
from io import StringIO
from fun_secrets import user, pw, host, db, authorization, API_URL, teamsOutWebhook

message = pymsteams.connectorcard(teamsOutWebhook)

start_time = time.time()

engine = sqlalchemy.create_engine(
    'mssql+pyodbc://{0}:{1}@{2}/{3}?driver=ODBC+Driver+18+for+SQL+Server'.format(user, pw, host, db),
    use_setinputsizes=False, fast_executemany=True)


def get_data():
    headers = {
        "Authorization": f"Bearer {authorization}",
        "Content-Type": "application/json"
    }
    response = requests.get(API_URL, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception(f"Error: {response.status_code} - {response.text}")


def load_data_to_df():
    data = StringIO(get_data()['json'])
    df = pd.read_json(data)
    df.rename(columns={'index': 'index',
                       'City': 'city',
                       'Date': 'transaction_date',
                       'Card Type': 'card_type',
                       'Exp Type': 'exp_type',
                       'Gender': 'gender',
                       'Amount': 'amount'}, inplace=True)
    return df


def main():
    try:
        data_df = load_data_to_df()
        with engine.connect() as conn:
            conn.exec_driver_sql("TRUNCATE TABLE src.mplus_transactions")
            conn.commit()
            conn.close()
        data_df.to_sql(con=engine, name='mplus_transactions', schema='src', if_exists='append', index=False)
        with engine.connect() as conn:
            conn.exec_driver_sql("""
                                EXEC dwh.exec_all;
                                """)
            conn.commit()
            conn.close()
        message.text('Radi :)')
        message.send()
    except Exception as e:
        message.text(str(e))
        message.send()
        print(e)


if __name__ == '__main__':
    main()
    print("--- %s seconds ---" % (time.time() - start_time))

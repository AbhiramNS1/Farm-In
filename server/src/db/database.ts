import * as mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config()




class DataBase {
    private static instance: DataBase;
    private pool: mysql.Pool;
    public static getInstance(): DataBase {
        if (!DataBase.instance) {
            DataBase.instance = new DataBase();
            DataBase.instance.pool= mysql.createPool({
                host: process.env.MYSQL_HOST,
                user: process.env.MYSQL_USER,
                password: process.env.MYSQL_PASSWORD,
                database: 'FarmIn',
                connectionLimit: 10,
            });
        }
        return DataBase.instance;
    }

   public async isVaildUser(email: string, password: string): Promise<boolean>{
        const [rows, fields] = await this.pool.execute('SELECT * FROM users WHERE email = ? AND password_hash = ?', [email, password]);
        if (Array.isArray(rows)) {
            return rows.length > 0;
        }
        else return false; 
   }
}

export default DataBase;
require('dotenv').config()

const express = require('express')

const app = express()
app.use(express.json())
const port = 5000

let mysql = require('mysql2')
let con = mysql.createConnection({
    host:process.env.DB_HOST,
    user: process.env.DB_USER,
    password:process.env.DB_PASS,
    database: process.env.DB_DB,
    port:process.env.DB_PORT
})


con.connect(function(err){
    if(err) throw err;
    console.log('Conectado')
})

app.get('/', (req, res)=>{
    res.send('Hello World')
})

app.get('/test',(req,res)=>{
    if(con.state == 'authenticated'){
        return res.status(200).send('COnexion DB: ok')
    }
    res.status(500).send('Error en conexion DB')
})

app.get('/tables',(req,res)=>{
    con.query('SHOW TABLES', (err, result)=>{
        if(err){
            return res.status(500).send('error en la query')
        }
        res.status(200).json(result)
    })
})

app.get('/empresas',(req,res)=>{
    con.query('SELECT * FROM Empresa', (err, result)=>{
        if(err){
            return res.status(500).send('error en la query')
        }
        res.status(200).json(result)
    })
})

app.get('/ciudad',(req,res)=>{
    console.log(req.body.empresa)
    con.query('SELECT p.name FROM Empresa e JOIN Empresa_Pais ep ON e.id = ep.id_empresa JOIN Pais p ON p.id = ep.id_pais WHERE e.name = ?',[req.body.empresa], (err,result)=>{
        if(err){
            return res.status(500).send(err)
        }
        res.status(200).json(result)
    })
})

app.get('/sede',(req,res)=>{
    con.query('SELECT s.name FROM Sede s JOIN Empresa e ON s.id_empresa = e.id JOIN Pais p ON s.id_pais = p.id WHERE UPPER(p.name) = UPPER(?) AND UPPER(e.name) = UPPER(?)',[req.body.Pais, req.body.Empresa],(err,result)=>{
        if(err){
            return res.status(500).send(err)
        }
        res.status(200).json(result)
    })
})

app.listen(port, ()=>{
    console.log(`server listen on port: ${port}`)
})


## Bootstrap
Bootstrap adalah framework CCS, HTML serta JavaScript yang memiliki fungsi untuk dapat mendesain sebuah web saja yang responsif sehingga saat diakses akan lebih mudah dan cepat. 
**File bootstrap diupload dalam bentuk .rar dikarenakan file yang terlalu banyak**
## Implementasi Konsep OOP
Sistem Informasi Perkuliahan JKB adalah sistem manajemen akademik yang komprehensif yang dirancang untuk mempermudah proses pengelolaan mata kuliah.  

![ERD](/images/erd.png)  

Pada implementasi OOP ini akan menggunakan table lecturer,corses dan couse_lecturer
### Buat database dan Table
![ERD](/images/lecturer.png)   
Buat tabel lecturer dengan id sebagai primary key
![ERD](/images/courses.png)
Buat tabel courses dengan id sebagai primary key
![ERD](/images/course_lecturers.png)
Buat tabel course_lecturers dengan id sebagai primary key,lecturer_id sebagai forgein key yang menghubungkakn course_lecturer dengan lecturer, course_id menghubungkan dengan table course.
### Buat koneksi agar terhubung dengan database
```php
class database //kelas dengan nama database
{
  //atribut bersifat privat
  private $host = "localhost";
  private $username = "root";
  private $password = "";
  private $database = "PWEB2"; //nama database
  private $koneksi;

  function __construct() //metode yang otomatis dibuat ketika kelas dibuat
  {
    $this->koneksi = mysqli_connect($this->host, $this->username, $this->password, $this->database); //ngekoneksikan dengan database
    if (mysqli_connect_errno()) {
      die("koneksi database gagal: " . mysqli_connect_error()); //jika koneksi gagal akan menampilkan pesan
    }
  }
  protected function query($sql) //bersifat protected karena agar bisa diturunkan ke kelas turunannya
  {
    return mysqli_query($this->koneksi, $sql);
  }
  function tampil() {} //metode dikosongkan, akan diisi di kelas turunan
}
```
Buat kelas database yang atributnya bersifat privat dengan menerapkan konsep encapsulation , kelas ini juga digunakan sebagai kelas induk yang atribut dan methodnya akan diturunkan
### Buat kelas turunan dengan menerapkan prinsip inheritance dan Polymorphism
inhertance diterapkan dengan membuat 3 kelas turunan dari kelas database. Polymorphism diterapkan dengan metode _tampil()_
```php
class lecturers extends database //kelas lecturers mewarisi kelas database
{
  public function tampil() //metode tampil untuk mengambil data didatabase table lecturer
  {
    $sql = "SELECT id, name, number_phone , address,signature,nidn,nip,user_id FROM lecturers "; //mengambil data dari kolom
    $result = $this->query($sql);
    $lecturers = []; //array kosong untuk menyimpan data

    if ($result->num_rows > 0) {
      while ($row = mysqli_fetch_array($result)) { //loop mengambil data
        $lecturers[] = $row;
      }
    }

    return $lecturers; //mengembalikan array yang berisi data lecturer
  }
}
```
kelas lecturer adalah turunan dari kelas database yang mewarisi metode yang ada dikelas database, metode _tampil()_ digunakan untuk mengambil data dari database table lecturer
```php
class courses extends database //kelas courses turunan dari database
{
  public function tampil() //metode yang diwariskan dari database digunakan untuk mengambil data dari database table course
  {
    $sql = "SELECT id,code,matkul,sks,hours,meeting,created_at,updated_at,deleted_at FROM courses"; //mengambil data dari kolom table courses
    $result = $this->query($sql);
    $courses = []; //array kosong untuk menyimpan data
    if ($result->num_rows > 0) { //loop mengambil data
      while ($row = mysqli_fetch_array($result)) {
        $courses[] = $row;
      }
    }

    return $courses; //mengembalikan array yang berisi data courses
  }
}
```
kelas course adalah turunan dari kelas database yang mewarisi metode yang ada dikelas database, metode _tampil()_ digunakan untuk mengambil data dari database table course
```php
class course_lecturers extends database //kelas course_lecturer merupakan kelas turunan dari database
{
  public function tampil() //metode yang diwariskan dari database disini digunakan untuk mengambil data dari table course dan lecturer
  {
    //menggunakan metode join untuk menggabungkan keduannya
    $sql =
      "SELECT  cl.id AS course_lecturer_id, 
                    l.name , 
                    l.number_phone, 
                    l.address, 
                    l.signature, 
                    l.nidn, 
                    l.nip,
                    c.code, 
                    c.matkul, 
                    c.sks, 
                    c.hours, 
                    c.meeting,
                    cl.created_at, 
                    cl.updated_at,
                    cl.deleted_at
                FROM 
                    course_lecturers cl
                JOIN 
                    lecturers l ON l.id = cl.lecturer_id
                JOIN 
                    courses c ON c.id = cl.course_id";
    $result = $this->query($sql);
    $course_lecturers = []; //array kosong untuk menyimpan data
    if ($result->num_rows > 0) {
      while ($row = mysqli_fetch_array($result)) {
        $course_lecturer[] = $row;
      }
    }

    return $course_lecturer; //mengembalikan array
  }
}
```
kelas course_lecturer adalah turunan dari kelas database yang mewarisi metode yang ada dikelas database, metode _tampil()_ digunakan untuk mengambil data dari database gabungan table course dan lecturer menggunakan JOIN

```php
$lecturers = new lecturers(); //instansiasi objek dari kelas lecturers
$lecturers1 = $lecturers->tampil(); //mengambil data dari tabel
``
Membuat objek baru dari kelas lecturer, dan memanggil metode tampil() untuk mengambil data dari lecturer
```php
$courses = new courses(); //instansiasi objek dari kelas courses
$courses1 = $courses->tampil(); //mengambil data dari tabel
```
Membuat objek baru dari kelas course, dan memanggil metode tampil() untuk mengambil data dari course

```php
$course_lecturer = new course_lecturers(); //instasiasi objek dari kelas course_lecturer
$course_lecturer1 = $course_lecturer->tampil(); //mengambil data
```
Membuat objek baru dari kelas course_lecturer, dan memanggil metode tampil() untuk mengambil data dari course_lecturer
```php
 $no = 1; //membuat nomor urut
    foreach ($course_lecturer1 as $row) { //looping menampilkan setiap baris data
    ?>

      <tr>
        <!--Menampilkan Data-->
        <td><?php echo $no++ ?></td>
        <td><?php echo $row['name'] ?></td>
        <td><?php echo $row['number_phone'] ?></td>
        <td><?php echo $row['address'] ?></td>
        <td><?php echo $row['signature'] ?></td>
        <td><?php echo $row['nidn'] ?></td>
        <td><?php echo $row['nip'] ?></td>
        <td><?php echo $row['code'] ?></td>
        <td><?php echo $row['matkul'] ?></td>
        <td><?php echo $row['sks'] ?></td>
        <td><?php echo $row['hours'] ?></td>
        <td><?php echo $row['meeting'] ?></td>
        <td><?php echo $row['deleted_at'] ?></td>
        <td><?php echo $row['created_at'] ?></td>
        <td><?php echo $row['updated_at'] ?></td>
      </tr>
    <?php } ?>
```
### Output
![ERD](/images/table_1.png)  
foreach digunakan untuk looping menampilkan data setiap barisnya
```php
 foreach ($lecturers1 as $row) { //looping menampilkan semua baris data

    ?>
      <!--Menampilkan Data-->
      <tr>
        <td><?php echo $row['id'] ?></td>
        <td><?php echo $row['name'] ?></td>
        <td><?php echo $row['number_phone'] ?></td>
        <td><?php echo $row['address'] ?></td>
        <td><?php echo $row['signature'] ?></td>
        <td><?php echo $row['nidn'] ?></td>
        <td><?php echo $row['nip'] ?></td>
        <td><?php echo $row['user_id'] ?></td>
      </tr>
    <?php } ?>
```
### Output
![ERD](/images/table_2.png)
```php
foreach ($courses1 as $row) { //looping menampilkan tiap baris data

    ?>
      <!--Menampilkan Data-->
      <tr>
        <td><?php echo $row['id'] ?></td>
        <td><?php echo $row['code'] ?></td>
        <td><?php echo $row['matkul'] ?></td>
        <td><?php echo $row['sks'] ?></td>
        <td><?php echo $row['hours'] ?></td>
        <td><?php echo $row['meeting'] ?></td>
        <td><?php echo $row['created_at'] ?></td>
        <td><?php echo $row['updated_at'] ?></td>
        <td><?php echo $row['deleted_at'] ?></td>
      </tr>
    <?php } ?>
```
### Output
![ERD](/images/table_3.png)
### Kode Program
```php
<?php
class database //kelas dengan nama database
{
  //atribut bersifat privat
  private $host = "localhost";
  private $username = "root";
  private $password = "";
  private $database = "PWEB2"; //nama database
  private $koneksi;

  function __construct() //metode yang otomatis dibuat ketika kelas dibuat
  {
    $this->koneksi = mysqli_connect($this->host, $this->username, $this->password, $this->database); //ngekoneksikan dengan database
    if (mysqli_connect_errno()) {
      die("koneksi database gagal: " . mysqli_connect_error()); //jika koneksi gagal akan menampilkan pesan
    }
  }
  protected function query($sql) //bersifat protected karena agar bisa diturunkan ke kelas turunannya
  {
    return mysqli_query($this->koneksi, $sql);
  }
  function tampil() {} //metode dikosongkan, akan diisi di kelas turunan
}


class lecturers extends database //kelas lecturers mewarisi kelas database
{
  public function tampil() //metode tampil untuk mengambil data didatabase table lecturer
  {
    $sql = "SELECT id, name, number_phone , address,signature,nidn,nip,user_id FROM lecturers "; //mengambil data dari kolom
    $result = $this->query($sql);
    $lecturers = []; //array kosong untuk menyimpan data

    if ($result->num_rows > 0) {
      while ($row = mysqli_fetch_array($result)) { //loop mengambil data
        $lecturers[] = $row;
      }
    }

    return $lecturers; //mengembalikan array yang berisi data lecturer
  }
}

class courses extends database //kelas courses turunan dari database
{
  public function tampil() //metode yang diwariskan dari database digunakan untuk mengambil data dari database table course
  {
    $sql = "SELECT id,code,matkul,sks,hours,meeting,created_at,updated_at,deleted_at FROM courses"; //mengambil data dari kolom table courses
    $result = $this->query($sql);
    $courses = []; //array kosong untuk menyimpan data
    if ($result->num_rows > 0) { //loop mengambil data
      while ($row = mysqli_fetch_array($result)) {
        $courses[] = $row;
      }
    }

    return $courses; //mengembalikan array yang berisi data courses
  }
}

class course_lecturers extends database //kelas course_lecturer merupakan kelas turunan dari database
{
  public function tampil() //metode yang diwariskan dari database disini digunakan untuk mengambil data dari table course dan lecturer
  {
    //menggunakan metode join untuk menggabungkan keduannya
    $sql =
      "SELECT  cl.id AS course_lecturer_id, 
                    l.name , 
                    l.number_phone, 
                    l.address, 
                    l.signature, 
                    l.nidn, 
                    l.nip,
                    c.code, 
                    c.matkul, 
                    c.sks, 
                    c.hours, 
                    c.meeting,
                    cl.created_at, 
                    cl.updated_at,
                    cl.deleted_at
                FROM 
                    course_lecturers cl
                JOIN 
                    lecturers l ON l.id = cl.lecturer_id
                JOIN 
                    courses c ON c.id = cl.course_id";
    $result = $this->query($sql);
    $course_lecturers = []; //array kosong untuk menyimpan data
    if ($result->num_rows > 0) {
      while ($row = mysqli_fetch_array($result)) {
        $course_lecturer[] = $row;
      }
    }

    return $course_lecturer; //mengembalikan array
  }
}
$lecturers = new lecturers(); //instansiasi objek dari kelas lecturers
$lecturers1 = $lecturers->tampil(); //mengambil data dari tabel
$courses = new courses(); //instansiasi objek dari kelas courses
$courses1 = $courses->tampil(); //mengambil data dari tabel
$course_lecturer = new course_lecturers(); //instasiasi objek dari kelas course_lecturer
$course_lecturer1 = $course_lecturer->tampil(); //mengambil data
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PWEB II</title>
</head>
<style>
  table {
    border-collapse: collapse;
  }

  th,
  td {
    border: 1px solid black;
    padding: 8px;
    text-align: left;
  }

  th {
    background-color: #f2f2f2;
  }

  tr:nth-child(even) {
    background-color: #f9f9f9;
  }

  tr:hover {
    background-color: #e0e0e0;
  }
</style>

<body>
  <!--tabel untuk menampilkan course lecturer-->
  <table>
    <tr>
      <th scope="col">No</th>
      <th scope="col">Nama</th>
      <th scope="col">Number Phone</th>
      <th scope="col">Address</th>
      <th scope="col">Signature</th>
      <th scope="col">NIDN</th>
      <th scope="col">NIP</th>
      <th scope="col">ID code</th>
      <th scope="col">Mata Kuliah</th>
      <th scope="col">SKS</th>
      <th scope="col">Jam</th>
      <th scope="col">Pertemuan</th>
      <th scope="col">Delete</th>
      <th scope="col">Created</th>
      <th scope="col">Updated</th>
    </tr>

    <?php
    $no = 1; //membuat nomor urut
    foreach ($course_lecturer1 as $row) { //looping menampilkan setiap baris data
    ?>

      <tr>
        <!--Menampilkan Data-->
        <td><?php echo $no++ ?></td>
        <td><?php echo $row['name'] ?></td>
        <td><?php echo $row['number_phone'] ?></td>
        <td><?php echo $row['address'] ?></td>
        <td><?php echo $row['signature'] ?></td>
        <td><?php echo $row['nidn'] ?></td>
        <td><?php echo $row['nip'] ?></td>
        <td><?php echo $row['code'] ?></td>
        <td><?php echo $row['matkul'] ?></td>
        <td><?php echo $row['sks'] ?></td>
        <td><?php echo $row['hours'] ?></td>
        <td><?php echo $row['meeting'] ?></td>
        <td><?php echo $row['deleted_at'] ?></td>
        <td><?php echo $row['created_at'] ?></td>
        <td><?php echo $row['updated_at'] ?></td>
      </tr>
    <?php } ?>
  </table>

  <br><br>
  <!--tabel untuk menampilkan lecturer-->
  <table>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Nama</th>
      <th scope="col">Number Phone</th>
      <th scope="col">Address</th>
      <th scope="col">Signature</th>
      <th scope="col">NIDN</th>
      <th scope="col">NIP</th>
      <th scope="col">User ID</th>
    </tr>
    <?php
    foreach ($lecturers1 as $row) { //looping menampilkan semua baris data

    ?>
      <!--Menampilkan Data-->
      <tr>
        <td><?php echo $row['id'] ?></td>
        <td><?php echo $row['name'] ?></td>
        <td><?php echo $row['number_phone'] ?></td>
        <td><?php echo $row['address'] ?></td>
        <td><?php echo $row['signature'] ?></td>
        <td><?php echo $row['nidn'] ?></td>
        <td><?php echo $row['nip'] ?></td>
        <td><?php echo $row['user_id'] ?></td>
      </tr>
    <?php } ?>
  </table>

  <br><br>

  <table>
    <!--tabel untuk menampilkan course-->
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Code</th>
      <th scope="col">Name</th>
      <th scope="col">SKS</th>
      <th scope="col">Hours</th>
      <th scope="col">Meeting</th>
      <th scope="col">Created</th>
      <th scope="col">Updated</th>
      <th scope="col">Deleted</th>
    </tr>
    <?php
    foreach ($courses1 as $row) { //looping menampilkan tiap baris data

    ?>
      <!--Menampilkan Data-->
      <tr>
        <td><?php echo $row['id'] ?></td>
        <td><?php echo $row['code'] ?></td>
        <td><?php echo $row['matkul'] ?></td>
        <td><?php echo $row['sks'] ?></td>
        <td><?php echo $row['hours'] ?></td>
        <td><?php echo $row['meeting'] ?></td>
        <td><?php echo $row['created_at'] ?></td>
        <td><?php echo $row['updated_at'] ?></td>
        <td><?php echo $row['deleted_at'] ?></td>
      </tr>
    <?php } ?>
  </table>
</body>
</html>
```







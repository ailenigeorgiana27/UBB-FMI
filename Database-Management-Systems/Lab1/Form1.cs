using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Xml.Linq;


namespace Lab1sgdb
{
    public partial class Form1 : Form
    {
        private string connectionString = @"Server=PC\SQLEXPRESS; Database=Patiserie_SGBD; Integrated Security=true; TrustServerCertificate=true;";

        private DataSet ds = new DataSet();
        SqlDataAdapter parentAdapter = new SqlDataAdapter();
        SqlDataAdapter childAdapter = new SqlDataAdapter();
        BindingSource parentBS = new BindingSource();
        BindingSource childBS = new BindingSource();

        private int produsSelectat = 0;
        private int tipSelectat = 0;
        private string denumireProdus;
        private string cantitateProdus;
        private string pretProdus;

        public Form1()
        {
            InitializeComponent();
            
        }


        public void refreshDataGridView()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    parentAdapter.SelectCommand = new SqlCommand("SELECT * FROM Tipuri;", connection);
                    childAdapter.SelectCommand = new SqlCommand("SELECT * FROM Produse;", connection);
                    ds.Clear();
                    parentAdapter.Fill(ds, "Tipuri");
                    childAdapter.Fill(ds, "Produse");
                    parentBS.DataSource = ds.Tables["Tipuri"];
                    dataGridViewParent.DataSource = parentBS;
                    dataGridViewChild.DataSource = childBS;

                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void dataGridViewParent_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0 && e.ColumnIndex >= 0)
            {
                DataGridViewRow row = dataGridViewParent.Rows[e.RowIndex];
                int.TryParse(row.Cells[0].Value.ToString(), out tipSelectat);
            }

            txtDenumire.Text = "";
            txtCantitate.Text = "";
            txtPret.Text = "";
        }

        private void DataGridViewChild_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.RowIndex >= 0 && e.ColumnIndex >= 0)
            {
                DataGridViewRow row = dataGridViewChild.Rows[e.RowIndex];
                int.TryParse(row.Cells[0].Value.ToString(), out produsSelectat);
                denumireProdus = row.Cells[1].Value.ToString();
                cantitateProdus = row.Cells[2].Value.ToString();
                pretProdus = row.Cells[3].Value.ToString();

            }

            txtDenumire.Text = denumireProdus;
            txtCantitate.Text = cantitateProdus;
            txtPret.Text = pretProdus;
        }

        private void btnAdaugaProdus_Click(object sender, EventArgs e)
        {
            if (tipSelectat == 0)
            {
                MessageBox.Show("ALEGETI UN TIP PENTRU PRODUS!!!");
            }
            else
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        SqlCommand insertCommand =
                            new SqlCommand(
                                "INSERT INTO Produse(Denumire, Cantitate, Pret, " +
                                "idTip) VALUES (@Denumire, @Cantitate, @Pret, @idTip);", connection);
                        insertCommand.Parameters.AddWithValue("@Denumire", txtDenumire.Text);
                        insertCommand.Parameters.AddWithValue("@Cantitate", txtCantitate.Text);
                        insertCommand.Parameters.AddWithValue("@Pret", txtPret.Text);
                        insertCommand.Parameters.AddWithValue("@idTip", tipSelectat);

                        int insertRowCount = insertCommand.ExecuteNonQuery();
                        MessageBox.Show("Produsul a fost adaugat cu succes!");
                        txtDenumire.Text = "";
                        txtCantitate.Text = "";
                        txtPret.Text = "";
                        refreshDataGridView();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        public void btnStergeProdus_Click(object sender, EventArgs e)
        {
            if (produsSelectat == 0)
            {
                MessageBox.Show("ALEGETI UN PRODUS!!!");
            }
            else
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        SqlCommand deleteCommand = new SqlCommand("DELETE FROM Produse WHERE idProduse = @idProduse;",
                            connection);
                        deleteCommand.Parameters.AddWithValue("@idProduse", produsSelectat);
                        int deleteRowCount = deleteCommand.ExecuteNonQuery();
                        MessageBox.Show("Produsul a fost sters");
                        txtDenumire.Text = "";
                        txtCantitate.Text = "";
                        txtPret.Text = "";
                        refreshDataGridView();
                        connection.Close();
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message); 
                }
            }
        }

        private void btnActualizeazaProdus_Click(object sender, EventArgs e)
        {
            if (produsSelectat == 0)
            {
                MessageBox.Show("ALEGETI UN PRODUS!!!");
            }
            else
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        SqlCommand updateCommand =
                            new SqlCommand(
                                "UPDATE Produse SET Denumire=@Denumire, Cantitate=@Cantitate, Pret=@Pret WHERE idProduse=@idProduse;",
                                connection);
                        updateCommand.Parameters.AddWithValue("@Denumire", txtDenumire.Text);
                        updateCommand.Parameters.AddWithValue("@Cantitate", txtCantitate.Text);
                        updateCommand.Parameters.AddWithValue("@Pret", txtPret.Text);
                        updateCommand.Parameters.AddWithValue("@idProduse", produsSelectat);
                        int updateRowCount = updateCommand.ExecuteNonQuery();
                        MessageBox.Show("Produsul a fost actualizat");
                        txtDenumire.Text = "";
                        txtCantitate.Text = "";
                        txtPret.Text = "";
                        refreshDataGridView();
                        connection.Close();

                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private void Patiserie_Load(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    parentAdapter.SelectCommand = new SqlCommand("SELECT * FROM Tipuri;", connection);
                    childAdapter.SelectCommand = new SqlCommand("SELECT * FROM Produse;", connection);
                    parentAdapter.Fill(ds, "Tipuri");
                    childAdapter.Fill(ds, "Produse");
                    parentBS.DataSource = ds.Tables["Tipuri"];
                    dataGridViewParent.DataSource = parentBS;
                    DataColumn parentColumn = ds.Tables["Tipuri"].Columns["idTip"];
                    DataColumn childColumn = ds.Tables["Produse"].Columns["idTip"];
                    DataRelation relation = new DataRelation("FK__Produse__idTip__3B75D760", parentColumn, childColumn);
                    ds.Relations.Add(relation);
                    childBS.DataSource = parentBS;
                    childBS.DataMember = "FK__Produse__idTip__3B75D760";
                    dataGridViewChild.DataSource = childBS;

                    connection.Close();

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void dataGridViewChild_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridViewParent_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }


    }


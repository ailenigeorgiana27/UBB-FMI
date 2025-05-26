using System.Drawing;
using System.Net.Mime;
using System.Windows.Forms;

namespace Lab1sgdb
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            dataGridViewParent = new DataGridView();
             dataGridViewChild = new DataGridView();
             label1 = new Label();
             label2 = new Label();
             label3 = new Label();
             txtDenumire = new TextBox();
             txtCantitate = new TextBox();
             txtPret = new TextBox();
             btnAdaugaProdus = new Button();
             btnStergeProdus = new Button();
             btnActualizeazaProdus = new Button();
            ((System.ComponentModel.ISupportInitialize)( dataGridViewParent)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)( dataGridViewChild)).BeginInit();
             SuspendLayout();
            // 
            // dataGridViewParent
            // 
             dataGridViewParent.BackgroundColor = Color.LightBlue;
             dataGridViewParent.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
             dataGridViewParent.GridColor = Color.LightBlue;
             dataGridViewParent.Location = new Point(44, 14);
             dataGridViewParent.Margin = new Padding(2, 2, 2, 2);
             dataGridViewParent.Name = "dataGridViewParent";
             dataGridViewParent.RowHeadersWidth = 51;
             dataGridViewParent.RowTemplate.Height = 29;
             dataGridViewParent.Size = new Size(416, 130);
             dataGridViewParent.TabIndex = 0;
             dataGridViewParent.CellClick += dataGridViewParent_CellClick;
             dataGridViewParent.CellContentClick += dataGridViewParent_CellContentClick;
            // 
            // dataGridViewChild
            // 
            dataGridViewChild.BackgroundColor = Color.LightBlue;
             dataGridViewChild.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
             dataGridViewChild.GridColor = Color.LightBlue;
             dataGridViewChild.Location = new Point(44, 161);
             dataGridViewChild.Margin = new Padding(2, 2, 2, 2);
             dataGridViewChild.Name = "dataGridViewChild";
             dataGridViewChild.RowHeadersWidth = 51;
             dataGridViewChild.RowTemplate.Height = 29;
             dataGridViewChild.Size = new Size(416, 130);
             dataGridViewChild.TabIndex = 1;
             dataGridViewChild.CellClick += DataGridViewChild_CellClick;
             dataGridViewChild.CellContentClick += dataGridViewChild_CellContentClick;
            // 
            // label1
            // 
            label1.AutoSize = true;
             label1.BackColor = Color.LightBlue;
             label1.Font = new Font("Sylfaen", 10.2F);
             label1.Location = new Point(87, 312);
             label1.Margin = new Padding(2, 0, 2, 0);
             label1.Name = "label1";
             label1.Size = new Size(63, 18);
             label1.TabIndex = 1;
             label1.Text = "Denumire";
            // 
            // label2
            // 
             label2.AutoSize = true;
             label2.BackColor = Color.LightBlue;
             label2.Font = new Font("Sylfaen", 10.2F);
             label2.Location = new Point(87, 336);
             label2.Margin = new Padding(2, 0, 2, 0);
             label2.Name = "label2";
             label2.Size = new Size(57, 18);
             label2.TabIndex = 2;
             label2.Text = "Cantitate";
            // 
            // label3
            // 
             label3.AutoSize = true;
             label3.BackColor = Color.LightBlue;
             label3.Font = new Font("Sylfaen", 10.2F);
             label3.Location = new Point(87, 360);
             label3.Margin = new Padding(2, 0, 2, 0);
             label3.Name = "label3";
             label3.Size = new Size(31, 18);
             label3.TabIndex = 3;
             label3.Text = "Pret";
            // 
            // txtDenumire
            // 
             txtDenumire.Font = new Font("Sylfaen", 10.2F);
             txtDenumire.Location = new Point(164, 307);
             txtDenumire.Margin = new Padding(2, 2, 2, 2);
             txtDenumire.Name = "txtDenumire";
             txtDenumire.Size = new Size(248, 25);
             txtDenumire.TabIndex = 2;
            // 
            // txtCantitate
            // 
             txtCantitate.Font = new Font("Sylfaen", 10.2F);
             txtCantitate.Location = new Point(164, 334);
             txtCantitate.Margin = new Padding(2, 2, 2, 2);
             txtCantitate.Name = "txtCantitate";
             txtCantitate.Size = new Size(248, 25);
             txtCantitate.TabIndex = 3;
            // 
            // txtPret
            // 
             txtPret.Font = new Font("Sylfaen", 10.2F);
             txtPret.Location = new Point(164, 361);
             txtPret.Margin = new Padding(2, 2, 2, 2);
             txtPret.Name = "txtPret";
             txtPret.Size = new Size(248, 25);
             txtPret.TabIndex = 4;
            // 
            // btnAdaugaProdus
            // 
             btnAdaugaProdus.BackColor = Color.SkyBlue;
             btnAdaugaProdus.Font = new Font("Sylfaen", 10.2F);
             btnAdaugaProdus.Location = new Point(88, 410);
             btnAdaugaProdus.Margin = new Padding(2, 2, 2, 2);
             btnAdaugaProdus.Name = "btnAdaugaProdus";
             btnAdaugaProdus.Size = new Size(322, 26);
             btnAdaugaProdus.TabIndex = 5;
             btnAdaugaProdus.Text = "Adaugă produsul";
             btnAdaugaProdus.UseVisualStyleBackColor = false;
             btnAdaugaProdus.Click += btnAdaugaProdus_Click;
            // 
            // btnStergeProdus
            // 
            btnStergeProdus.BackColor = Color.SkyBlue;
             btnStergeProdus.Font = new Font("Sylfaen", 10.2F);
             btnStergeProdus.Location = new Point(88, 440);
             btnStergeProdus.Margin = new Padding(2, 2, 2, 2);
             btnStergeProdus.Name = "btnStergeProdus";
             btnStergeProdus.Size = new Size(322, 26);
             btnStergeProdus.TabIndex = 6;
             btnStergeProdus.Text = "Șterge produsul";
             btnStergeProdus.UseVisualStyleBackColor = false;
             btnStergeProdus.Click += btnStergeProdus_Click;
            // 
            // btnActualizeazaProdus
            // 
             btnActualizeazaProdus.BackColor = Color.SkyBlue;
             btnActualizeazaProdus.Font = new Font("Sylfaen", 10.2F);
             btnActualizeazaProdus.Location = new Point(88, 470);
             btnActualizeazaProdus.Margin = new Padding(2, 2, 2, 2);
             btnActualizeazaProdus.Name = "btnActualizeazaProdus";
             btnActualizeazaProdus.Size = new Size(322, 26);
             btnActualizeazaProdus.TabIndex = 7;
             btnActualizeazaProdus.Text = "Actualizează produsul";
             btnActualizeazaProdus.UseVisualStyleBackColor = false;
            btnActualizeazaProdus.Click += btnActualizeazaProdus_Click;
            // 
            // Form1
            // 
             AutoScaleDimensions = new SizeF(6F, 13F);
             AutoScaleMode = AutoScaleMode.Font;
             ClientSize = new Size(493, 524);
             Controls.Add( btnActualizeazaProdus);
             Controls.Add( btnStergeProdus);
             Controls.Add( btnAdaugaProdus);
             Controls.Add( txtDenumire);
             Controls.Add( txtCantitate);
             Controls.Add( txtPret);
             Controls.Add( label3);
             Controls.Add( label2);
             Controls.Add( label1);
             Controls.Add( dataGridViewChild);
             Controls.Add( dataGridViewParent);
             Margin = new Padding(2, 2, 2, 2);
             Name = "Patiserie";
             Text = "Patiserie";
             Load += Patiserie_Load;
            ((System.ComponentModel.ISupportInitialize)( dataGridViewParent)).EndInit();
            ((System.ComponentModel.ISupportInitialize)( dataGridViewChild)).EndInit();
             ResumeLayout(false);
             PerformLayout();

        }

      

        #endregion

        private DataGridView dataGridViewParent;
        private DataGridView dataGridViewChild;
        private Label label1;
        private Label label2;
        private Label label3;
        private TextBox txtDenumire;
        private TextBox txtCantitate;
        private TextBox txtPret;
        private Button btnAdaugaProdus;
        private Button btnStergeProdus;
        private Button btnActualizeazaProdus;

    }
}


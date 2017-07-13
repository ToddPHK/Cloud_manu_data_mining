using System;

/// <summary>
///GM 的摘要说明
/// </summary>
namespace Model
{
    public class GM
    {
        private int length = 0;         //原始数据的个数
        private int n = 0;              //待预测的数据个数
        private double[] x = null;      //原始数据
        private double[] x1 = null;     //累加生成数据
        private double[] X1 = null;             //预测的AGO1数列
        private double[] X = null;              //预测的结果
        //private double[] x2 = null; 

        public GM(double[] value, int num)
        {
            n = num;
            length = value.GetLength(0);
            x = new double[length];// 分配内存
            x = value;

        }

        public double[] AGO1()
        {
            double t = 0;
            x1 = new double[length];// 分配内存

            x1[0] = x[0];//x1为累加生成序列
            //x2[0] = x[0];
            for (int i = 1; i < length; i++)
            {
                for (int j = 0; j <= i; j++)
                    t += x[j];
                x1[i] = t;
                t = 0;
            }
            return x1;
        }

        public double[] Result()
        {
            this.AGO1();
            double[,] B = new double[length - 1, 2];
            double[] Yn = new double[length - 1];
            X1 = new double[length + n];   //预测的AGO1数列，分配内存
            X = new double[length + n];    //预测的结果，分配内存


            for (int i = 0; i < length - 1; i++)
            {
                B[i, 0] = -(x1[i] + x1[i + 1]) / 2;
                B[i, 1] = 1;
            }
            //return B;
            for (int i = 1; i < length; i++)
            {
                Yn[i - 1] = x[i];
            }
            //return Yn;
            Matrix matr1 = new Matrix(B);
            Matrix matr2 = new Matrix(length - 1, 1, Yn);
            Matrix A1 = new Matrix(2, 2, matr1.Transpose() * matr1);
            Matrix A2 = new Matrix(2, length - 1, A1.InvertGaussJordan() * matr1.Transpose());
            Matrix A = A2 * matr2;
            double a = A.GetElement(0, 0);
            double u = A.GetElement(1, 0);
            X1[0] = x[0];
            for (int i = 0; i < (length + n - 1); i++)
            {
                X1[i + 1] = (x[0] - u / a) * Math.Pow(Math.E, -a * (i + 1)) + u / a;
            }
            X[0] = x[0];
            for (int i = length + n - 1; i > 0; i--)
            {
                X[i] = X1[i] - X1[i - 1];
            }
            return X;
        }
    }
}
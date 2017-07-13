using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Xml.Linq;

/// <summary>
///LinearRegression 的摘要说明
/// </summary>
namespace Model
{
    public class LinearRegression
    {
        private int length = 0;         //原始数据的个数
        private int n = 0;              //待预测的数据个数
        private double[] y = null;      //因变量原始数据
        private double[] x1 = null;      //自变量原始数据
        private double[] x2 = null;      //自变量原始数据
        private double[] Res = null;      //因变量预测数据


        /// <summary>
        /// Initializes a new instance of the <see cref="LinearRegression"/> class.
        /// </summary>
        /// <param name="value1">原始数据（y轴）</param>
        /// <param name="value2">x轴数据</param>
        /// <param name="value3">The value3.</param>
        /// <param name="num">预测长度</param>
        public LinearRegression(double[] value1, double[] value2, double[] value3, int num)
        {
            n = num;
            length = value1.GetLength(0);
            y = new double[length];     // 分配内存
            x1 = new double[length + n];    // 分配内存
            x2 = new double[length + n];    // 分配内存
            y = value1;
            x1 = value2;
            x2 = value3;
        }

        public LinearRegression(double[] value1, double[] value2, int num)
        {
            n = num;
            length = value1.GetLength(0);
            y = new double[length];     // 分配内存
            x1 = new double[length + n];    // 分配内存

            y = value1;
            x1 = value2;

        }

        /// <summary>
        /// 一阶线性回归预测结果
        /// </summary>
        /// <ref> 参考文献【回归分析法在服装流行色预测中的应用】 </ref>         
        public double[] FirResult()
        {
            double[,] X = new double[length, 2];
            double[] B = new double[2];
            for (int i = 0; i < length; i++)
            {
                X[i, 0] = 1;
                X[i, 1] = x1[i];
            }

            Matrix matr1 = new Matrix(X);
            Matrix matr2 = new Matrix(length, 1, y);
            Matrix A1 = new Matrix(2, 2, matr1.Transpose() * matr1);
            Matrix A2 = new Matrix(2, length, A1.InvertGaussJordan() * matr1.Transpose());
            Matrix A = A2 * matr2;
            B[0] = A.GetElement(0, 0);
            B[1] = A.GetElement(1, 0);

            Res = new double[length + n];
            for (int i = 0; i < length + n; i++)
            {
                Res[i] = B[0] + B[1] * x1[i];
            }
            return Res;
        }

        /// <summary>
        /// 二阶线性回归预测结果
        /// </summary>
        public double[] SecResult()
        {
            double[,] X = new double[length, 3];
            double[] B = new double[3];
            for (int i = 0; i < length; i++)
            {
                X[i, 0] = 1;
                X[i, 1] = x1[i];
                X[i, 2] = x2[i];
            }

            Matrix matr1 = new Matrix(X);
            Matrix matr2 = new Matrix(length, 1, y);
            Matrix A1 = new Matrix(3, 3, matr1.Transpose() * matr1);
            Matrix A2 = new Matrix(3, length, A1.InvertGaussJordan() * matr1.Transpose());
            Matrix A = A2 * matr2;
            B[0] = A.GetElement(0, 0);
            B[1] = A.GetElement(1, 0);
            B[2] = A.GetElement(2, 0);

            Res = new double[length + n];
            for (int i = 0; i < length + n; i++)
            {
                Res[i] = B[0] + B[1] * x1[i] + B[2] * x2[i];
            }
            return Res;
        }
    }
}